import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/all_products.dart';
import '../../../domain/usecases/get_all_products_usecase.dart';
part 'all_products_event.dart';
part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  final GetAllProductsUseCase getAllProductsUseCase;

  AllProductsBloc({required this.getAllProductsUseCase})
    : super(AllProductsInitial()) {
    on<AllProductsRequested>(getAllProducts);
  }

  Future<void> getAllProducts(
    AllProductsRequested event,
    Emitter<AllProductsState> emit,
  ) async {
    emit(AllProductsLoading());
    final result = await getAllProductsUseCase.call();
    result.fold(
      (failure) => emit(AllProductsError(failure.message)),
      (response) => emit(AllProductsLoaded(response)),
    );
  }
}
