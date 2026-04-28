import 'package:dio/dio.dart';
import 'package:dummy_app_2026/features/products/data/model/product_model.dart';
import 'package:dummy_app_2026/features/products/data/model/all_products_model.dart';

import '../../../../core/errors/exceptions.dart';

abstract class ProductRemoteDatasource {
  Future<ProductModel> getProduct({required int id});
  Future<AllProductsModel> getAllProducts();
  Future<AllProductsModel> searchProducts({required String query});
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final Dio dio;

  ProductRemoteDatasourceImpl({required this.dio});

  @override
  Future<ProductModel> getProduct({required int id}) async {
    try {
      final response = await dio.get('/products/$id');
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Get single product failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<AllProductsModel> getAllProducts() async {
    try {
      final response = await dio.get('/products');
      return AllProductsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Get all products failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<AllProductsModel> searchProducts({required String query}) async {
    try {
      final response = await dio.get('/products/search', queryParameters: {'q': query});
      return AllProductsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Search products failed',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
