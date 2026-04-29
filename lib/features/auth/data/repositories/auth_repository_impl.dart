import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/storage/hive_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final HiveService hiveService;

  AuthRepositoryImpl({required this.remoteDataSource, required this.hiveService});

  @override
  Future<Either<Failure, User>> login({
    required String username,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        username: username,
        password: password,
      );

      await hiveService.saveTokens(
        accessToken: user.accessToken,
        refreshToken: user.refreshToken,
      );

      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
