import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../storage/hive_service.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // ---------- Core ----------
  getIt.registerSingleton<HiveService>(HiveService());
  getIt.registerSingleton<Dio>(DioClient.createDio(getIt<HiveService>()));

  // ---------- Auth ----------
  getIt.registerSingleton<AuthRemoteDataSource>(
    AuthRemoteDataSourceImpl(getIt<Dio>()),
  );
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      hiveService: getIt<HiveService>(),
    ),
  );
  getIt.registerSingleton<LoginUseCase>(LoginUseCase(getIt<AuthRepository>()));
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(loginUseCase: getIt<LoginUseCase>()),
  );
}
