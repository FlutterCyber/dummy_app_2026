import 'package:dartz/dartz.dart';
import 'package:dummy_app_2026/features/products/domain/entity/product.dart';
import 'package:dummy_app_2026/features/products/domain/entity/all_products.dart';
import 'package:dummy_app_2026/features/products/domain/entity/category.dart';
import 'package:dummy_app_2026/features/products/domain/entity/new_product.dart';
import '../../../../core/errors/failures.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> getProduct({required int id});
  Future<Either<Failure, AllProductsResponse>> getAllProducts({String? sortBy, String? order});
  Future<Either<Failure, AllProductsResponse>> searchProducts({required String query, String? sortBy, String? order});
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, AllProductsResponse>> getProductsByCategory({required String slug, String? sortBy, String? order});
  Future<Either<Failure, Product>> addProduct({required NewProduct newProduct});
}
