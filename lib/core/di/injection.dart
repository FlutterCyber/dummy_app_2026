import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../storage/hive_service.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/products/data/datasource/product_remote_datasource.dart';
import '../../features/products/data/repository/product_repository_impl.dart';
import '../../features/products/domain/repository/product_repository.dart';
import '../../features/products/domain/usecases/get_single_product_usecase.dart';
import '../../features/products/presentation/bloc/one_product/product_bloc.dart';
import '../../features/products/presentation/bloc/all_products/all_products_bloc.dart';
import '../../features/products/domain/usecases/get_all_products_usecase.dart';
import '../../features/products/domain/usecases/search_products_usecase.dart';
import '../../features/products/domain/usecases/get_categories_usecase.dart';
import '../../features/products/domain/usecases/get_products_by_category_usecase.dart';
import '../../features/products/presentation/bloc/categories/categories_bloc.dart';
import '../../features/products/presentation/bloc/category_products/category_products_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // ---------- Core ----------
  getIt.registerSingleton<HiveService>(HiveService());
  getIt.registerSingleton<Dio>(DioClient.createDio());

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

  // ---------- Products ----------
  getIt.registerSingleton<ProductRemoteDatasource>(
    ProductRemoteDatasourceImpl(dio: getIt<Dio>()),
  );
  getIt.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(productRemoteDatasource: getIt<ProductRemoteDatasource>()),
  );
  getIt.registerSingleton<GetSingleProductUseCase>(
    GetSingleProductUseCase(getIt<ProductRepository>()),
  );
  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(getSingleProductUseCase: getIt<GetSingleProductUseCase>()),
  );
  getIt.registerSingleton<GetAllProductsUseCase>(
    GetAllProductsUseCase(getIt<ProductRepository>()),
  );
  getIt.registerSingleton<SearchProductsUseCase>(
    SearchProductsUseCase(getIt<ProductRepository>()),
  );
  getIt.registerFactory<AllProductsBloc>(
    () => AllProductsBloc(
      getAllProductsUseCase: getIt<GetAllProductsUseCase>(),
      searchProductsUseCase: getIt<SearchProductsUseCase>(),
    ),
  );
  getIt.registerSingleton<GetCategoriesUseCase>(
    GetCategoriesUseCase(getIt<ProductRepository>()),
  );
  getIt.registerSingleton<GetProductsByCategoryUseCase>(
    GetProductsByCategoryUseCase(getIt<ProductRepository>()),
  );
  getIt.registerFactory<CategoriesBloc>(
    () => CategoriesBloc(getCategoriesUseCase: getIt<GetCategoriesUseCase>()),
  );
  getIt.registerFactory<CategoryProductsBloc>(
    () => CategoryProductsBloc(
      getProductsByCategoryUseCase: getIt<GetProductsByCategoryUseCase>(),
    ),
  );
}
