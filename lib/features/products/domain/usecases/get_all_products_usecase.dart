import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entity/all_products.dart';
import '../repository/product_repository.dart';

class GetAllProductsUseCase {
  final ProductRepository productRepository;

  GetAllProductsUseCase(this.productRepository);

  Future<Either<Failure, AllProductsResponse>> call() {
    return productRepository.getAllProducts();
  }
}
