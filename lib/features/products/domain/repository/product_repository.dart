import 'package:dartz/dartz.dart';
import 'package:dummy_app_2026/features/products/domain/entity/product.dart';
import 'package:dummy_app_2026/features/products/domain/entity/all_products.dart';
import '../../../../core/errors/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> getProduct({required int id});
  Future<Either<Failure, AllProductsResponse>> getAllProducts();
  Future<Either<Failure, AllProductsResponse>> searchProducts({required String query});
}
