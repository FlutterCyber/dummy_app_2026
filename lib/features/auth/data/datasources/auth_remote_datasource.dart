import 'package:dio/dio.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String username, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'username': username, 'password': password, 'expiresInMins': 60},
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Login failed',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
