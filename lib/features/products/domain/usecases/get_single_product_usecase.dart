import 'package:dartz/dartz.dart';
import 'package:dummy_app_2026/features/products/domain/entity/product.dart';
import 'package:dummy_app_2026/features/products/domain/repository/product_repository.dart';
import '../../../../core/errors/failures.dart';

class GetSingleProductUseCase {
  final ProductRepository productRepository;

  GetSingleProductUseCase(this.productRepository);

  Future<Either<Failure, Product>> call({required int id}) {
    return productRepository.getProduct(id: id);
  }
}
