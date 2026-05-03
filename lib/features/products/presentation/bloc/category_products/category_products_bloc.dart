import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/all_products.dart';
import '../../../domain/usecases/get_products_by_category_usecase.dart';

part 'category_products_event.dart';
part 'category_products_state.dart';

class CategoryProductsBloc extends Bloc<CategoryProductsEvent, CategoryProductsState> {
  final GetProductsByCategoryUseCase getProductsByCategoryUseCase;

  CategoryProductsBloc({required this.getProductsByCategoryUseCase})
      : super(CategoryProductsInitial()) {
    on<CategoryProductsRequested>(_getProductsByCategory);
  }

  Future<void> _getProductsByCategory(
    CategoryProductsRequested event,
    Emitter<CategoryProductsState> emit,
  ) async {
    emit(CategoryProductsLoading());
    final result = await getProductsByCategoryUseCase.call(
      slug: event.slug,
      sortBy: event.sortBy,
      order: event.order,
    );
    result.fold(
      (failure) => emit(CategoryProductsError(failure.message)),
      (response) => emit(CategoryProductsLoaded(response)),
    );
  }
}
