import 'package:dio/dio.dart';
import '../storage/hive_service.dart';

class AuthInterceptor extends Interceptor {
  final HiveService hiveService;
  final Dio dio;

  AuthInterceptor({required this.hiveService, required this.dio});

  // Har bir so'rov ketishidan oldin ishlaydi
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = hiveService.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  // Xatolik kelganda ishlaydi
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 401 = token muddati tugagan
    if (err.response?.statusCode == 401) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        // Yangi token bilan asl so'rovni qayta yuborish
        final response = await _retry(err.requestOptions);
        handler.resolve(response);
        return;
      }
    }
    handler.next(err);
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = hiveService.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await dio.post(
        '/auth/refresh',
        data: {'refreshToken': refreshToken, 'expiresInMins': 60},
      );

      await hiveService.saveTokens(
        accessToken: response.data['accessToken'],
        refreshToken: response.data['refreshToken'],
      );
      return true;
    } catch (_) {
      await hiveService.clearTokens();
      return false;
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final token = hiveService.getAccessToken();
    final options = Options(
      method: requestOptions.method,
      headers: {'Authorization': 'Bearer $token'},
    );
    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
