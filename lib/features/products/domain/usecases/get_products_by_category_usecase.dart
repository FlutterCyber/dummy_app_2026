import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entity/all_products.dart';
import '../repository/product_repository.dart';

class GetProductsByCategoryUseCase {
  final ProductRepository productRepository;

  GetProductsByCategoryUseCase(this.productRepository);

  Future<Either<Failure, AllProductsResponse>> call({
    required String slug,
    String? sortBy,
    String? order,
  }) {
    return productRepository.getProductsByCategory(
      slug: slug,
      sortBy: sortBy,
      order: order,
    );
  }
}
