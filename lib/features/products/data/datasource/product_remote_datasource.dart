import 'package:dio/dio.dart';
import 'package:dummy_app_2026/features/products/data/model/product_model.dart';
import 'package:dummy_app_2026/features/products/data/model/all_products_model.dart';

import '../../../../core/errors/exceptions.dart';

abstract class ProductRemoteDatasource {
  Future<ProductModel> getProduct({required int id});

  Future<AllProductsModel> getAllProducts({String? sortBy, String? order});

  Future<AllProductsModel> searchProducts({
    required String query,
    String? sortBy,
    String? order,
  });
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
  Future<AllProductsModel> getAllProducts({
    String? sortBy,
    String? order,
  }) async {
    try {
      final queryParameters = <String, dynamic>{};
      if (sortBy != null) queryParameters['sortBy'] = sortBy;
      if (order != null) queryParameters['order'] = order;
      final response = await dio.get(
        '/products',
        queryParameters: queryParameters,
      );
      return AllProductsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Get all products failed',
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<AllProductsModel> searchProducts({
    required String query,
    String? sortBy,
    String? order,
  }) async {
    try {
      final queryParameters = <String, dynamic>{'q': query};
      if (sortBy != null) queryParameters['sortBy'] = sortBy;
      if (order != null) queryParameters['order'] = order;
      final response = await dio.get(
        '/products/search',
        queryParameters: queryParameters,
      );
      return AllProductsModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: e.response?.data['message'] ?? 'Search products failed',
        statusCode: e.response?.statusCode,
      );
    }
  }
}
