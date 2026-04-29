import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entity/all_products.dart';
import '../repository/product_repository.dart';

class SearchProductsUseCase {
  final ProductRepository productRepository;

  SearchProductsUseCase(this.productRepository);

  Future<Either<Failure, AllProductsResponse>> call({required String query, String? sortBy, String? order}) {
    return productRepository.searchProducts(query: query, sortBy: sortBy, order: order);
  }
}
