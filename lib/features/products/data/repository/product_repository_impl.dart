import 'package:dartz/dartz.dart';
import 'package:dummy_app_2026/features/products/data/datasource/product_remote_datasource.dart';
import 'package:dummy_app_2026/features/products/domain/repository/product_repository.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entity/product.dart';
import '../../domain/entity/all_products.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource productRemoteDatasource;

  ProductRepositoryImpl({required this.productRemoteDatasource});

  @override
  Future<Either<Failure, Product>> getProduct({required int id}) async {
    try {
      final product = await productRemoteDatasource.getProduct(id: id);
      return Right(product);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AllProductsResponse>> getAllProducts() async {
    try {
      final result = await productRemoteDatasource.getAllProducts();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
