import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import 'auth_interceptor.dart';
import '../storage/hive_service.dart';

class DioClient {
  static Dio createDio(HiveService hiveService) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(hiveService: hiveService, dio: dio),
      LogInterceptor(
        request: true,
        responseBody: true,
        error: true,
      ),
    ]);

    return dio;
  }
}
