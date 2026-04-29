import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entity/all_products.dart';
import '../../../domain/usecases/get_all_products_usecase.dart';
import '../../../domain/usecases/search_products_usecase.dart';
part 'all_products_event.dart';
part 'all_products_state.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final SearchProductsUseCase searchProductsUseCase;

  AllProductsBloc({
    required this.getAllProductsUseCase,
    required this.searchProductsUseCase,
  }) : super(AllProductsInitial()) {
    on<AllProductsRequested>(_getAllProducts);
    on<SearchProductsRequested>(_searchProducts);
  }

  Future<void> _getAllProducts(
    AllProductsRequested event,
    Emitter<AllProductsState> emit,
  ) async {
    emit(AllProductsLoading());
    final result = await getAllProductsUseCase.call(sortBy: event.sortBy, order: event.order);
    result.fold(
      (failure) => emit(AllProductsError(failure.message)),
      (response) => emit(AllProductsLoaded(response)),
    );
  }

  Future<void> _searchProducts(
    SearchProductsRequested event,
    Emitter<AllProductsState> emit,
  ) async {
    emit(AllProductsLoading());
    final result = await searchProductsUseCase.call(query: event.query, sortBy: event.sortBy, order: event.order);
    result.fold(
      (failure) => emit(AllProductsError(failure.message)),
      (response) => emit(AllProductsLoaded(response)),
    );
  }
}
