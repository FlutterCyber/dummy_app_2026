import 'package:dummy_app_2026/features/products/domain/entity/product.dart';

import '../../domain/entity/all_products.dart';
import 'product_model.dart';

class AllProductsModel extends AllProductsResponse {
  AllProductsModel({
    required super.products,
    required super.total,
    required super.skip,
    required super.limit,
  });

  factory AllProductsModel.fromJson(Map<String, dynamic> json) =>
      AllProductsModel(
        products: List<Product>.from(
          json["products"].map((x) => ProductModel.fromJson(x)),
        ),
        total: json["total"] ?? 0,
        skip: json["skip"] ?? 0,
        limit: json["limit"] ?? 0,
      );
}
