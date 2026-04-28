part of 'all_products_bloc.dart';

abstract class AllProductsEvent extends Equatable {
  const AllProductsEvent();

  @override
  List<Object> get props => [];
}

class AllProductsRequested extends AllProductsEvent {
  const AllProductsRequested();
}

class SearchProductsRequested extends AllProductsEvent {
  final String query;
  const SearchProductsRequested(this.query);

  @override
  List<Object> get props => [query];
}
