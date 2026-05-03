import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entity/new_product.dart';
import '../entity/product.dart';
import '../repository/product_repository.dart';

class AddProductUseCase {
  final ProductRepository productRepository;

  AddProductUseCase(this.productRepository);

  Future<Either<Failure, Product>> call({required NewProduct newProduct}) {
    return productRepository.addProduct(newProduct: newProduct);
  }
}
