part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class SingleProductRequested extends ProductEvent {
  final int id;

  const SingleProductRequested({required this.id});

  @override
  List<Object> get props => [id];
}
