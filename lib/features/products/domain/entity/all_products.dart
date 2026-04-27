import 'product.dart';

class AllProductsResponse {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  AllProductsResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });
}
