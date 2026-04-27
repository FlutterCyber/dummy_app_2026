part of 'all_products_bloc.dart';

abstract class AllProductsState extends Equatable {
  const AllProductsState();

  @override
  List<Object?> get props => [];
}

class AllProductsInitial extends AllProductsState {}

class AllProductsLoading extends AllProductsState {}

class AllProductsLoaded extends AllProductsState {
  final AllProductsResponse allProductsResponse;

  const AllProductsLoaded(this.allProductsResponse);

  @override
  List<Object?> get props => [allProductsResponse];
}

class AllProductsError extends AllProductsState {
  final String message;

  const AllProductsError(this.message);

  @override
  List<Object?> get props => [message];
}
