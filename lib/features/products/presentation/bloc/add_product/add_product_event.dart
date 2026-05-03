part of 'add_product_bloc.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object?> get props => [];
}

class AddProductSubmitted extends AddProductEvent {
  final NewProduct newProduct;

  const AddProductSubmitted(this.newProduct);

  @override
  List<Object?> get props => [newProduct];
}
