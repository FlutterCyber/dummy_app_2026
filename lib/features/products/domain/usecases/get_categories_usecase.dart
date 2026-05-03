import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entity/category.dart';
import '../repository/product_repository.dart';

class GetCategoriesUseCase {
  final ProductRepository productRepository;

  GetCategoriesUseCase(this.productRepository);

  Future<Either<Failure, List<Category>>> call() {
    return productRepository.getCategories();
  }
}
