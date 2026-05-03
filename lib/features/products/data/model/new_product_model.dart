import '../../domain/entity/new_product.dart';

class NewProductModel extends NewProduct {
  NewProductModel({
    required super.title,
    required super.description,
    required super.price,
    required super.discountPercentage,
    required super.stock,
    required super.brand,
    required super.category,
    required super.thumbnail,
  });

  factory NewProductModel.fromEntity(NewProduct entity) => NewProductModel(
    title: entity.title,
    description: entity.description,
    price: entity.price,
    discountPercentage: entity.discountPercentage,
    stock: entity.stock,
    brand: entity.brand,
    category: entity.category,
    thumbnail: entity.thumbnail,
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'price': price,
    'discountPercentage': discountPercentage,
    'stock': stock,
    'brand': brand,
    'category': category,
    'thumbnail': thumbnail,
  };
}
