part of 'all_products_bloc.dart';

abstract class AllProductsEvent extends Equatable {
  const AllProductsEvent();

  @override
  List<Object?> get props => [];
}

class AllProductsRequested extends AllProductsEvent {
  final String? sortBy;
  final String? order;

  const AllProductsRequested({this.sortBy, this.order});

  @override
  List<Object?> get props => [sortBy, order];
}

class SearchProductsRequested extends AllProductsEvent {
  final String query;
  final String? sortBy;
  final String? order;

  const SearchProductsRequested(this.query, {this.sortBy, this.order});

  @override
  List<Object?> get props => [query, sortBy, order];
}
