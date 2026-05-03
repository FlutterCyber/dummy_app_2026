import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/new_product.dart';
import '../../../domain/entity/product.dart';
import '../../../domain/usecases/add_product_usecase.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final AddProductUseCase addProductUseCase;

  AddProductBloc({required this.addProductUseCase}) : super(AddProductInitial()) {
    on<AddProductSubmitted>(_addProduct);
  }

  Future<void> _addProduct(
    AddProductSubmitted event,
    Emitter<AddProductState> emit,
  ) async {
    emit(AddProductLoading());
    final result = await addProductUseCase.call(newProduct: event.newProduct);
    result.fold(
      (failure) => emit(AddProductError(failure.message)),
      (product) => emit(AddProductSuccess(product)),
    );
  }
}
