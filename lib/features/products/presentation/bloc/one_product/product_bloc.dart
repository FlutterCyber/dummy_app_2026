import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/product.dart';
import '../../../domain/usecases/get_single_product_usecase.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetSingleProductUseCase getSingleProductUseCase;

  ProductBloc({required this.getSingleProductUseCase})
    : super(ProductInitial()) {
    on<SingleProductRequested>(getSingleProduct);
  }

  Future<void> getSingleProduct(
    SingleProductRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await getSingleProductUseCase.call(id: event.id);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (product) => emit(ProductLoaded(product)),
    );
  }
}
