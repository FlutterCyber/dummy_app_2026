part of 'category_products_bloc.dart';

abstract class CategoryProductsEvent extends Equatable {
  const CategoryProductsEvent();

  @override
  List<Object?> get props => [];
}

class CategoryProductsRequested extends CategoryProductsEvent {
  final String slug;
  final String? sortBy;
  final String? order;

  const CategoryProductsRequested(this.slug, {this.sortBy, this.order});

  @override
  List<Object?> get props => [slug, sortBy, order];
}
