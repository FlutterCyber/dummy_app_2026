import 'package:dummy_app_2026/features/products/domain/entity/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.tags,
    required super.brand,
    required super.sku,
    required super.weight,
    required super.dimensions,
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required super.reviews,
    required super.returnPolicy,
    required super.minimumOrderQuantity,
    required super.meta,
    required super.thumbnail,
    required super.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"] ?? 0,
    title: json["title"] ?? '',
    description: json["description"] ?? '',
    category: json["category"] ?? '',
    price: json["price"]?.toDouble() ?? 0.0,
    discountPercentage: json["discountPercentage"]?.toDouble() ?? 0.0,
    rating: json["rating"]?.toDouble() ?? 0.0,
    stock: json["stock"] ?? 0,
    tags: List<String>.from((json["tags"] ?? []).map((x) => x)),
    brand: json["brand"] ?? '',
    sku: json["sku"] ?? '',
    weight: json["weight"] ?? 0,
    dimensions: DimensionsModel.fromJson(json["dimensions"] ?? {}),
    warrantyInformation: json["warrantyInformation"] ?? '',
    shippingInformation: json["shippingInformation"] ?? '',
    availabilityStatus: json["availabilityStatus"] ?? '',
    reviews: List<Review>.from(
      (json["reviews"] ?? []).map((x) => ReviewModel.fromJson(x)),
    ),
    returnPolicy: json["returnPolicy"] ?? '',
    minimumOrderQuantity: json["minimumOrderQuantity"] ?? 0,
    meta: MetaModel.fromJson(json["meta"] ?? {}),
    thumbnail: json["thumbnail"] ?? '',
    images: List<String>.from((json["images"] ?? []).map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "category": category,
    "price": price,
    "discountPercentage": discountPercentage,
    "rating": rating,
    "stock": stock,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "brand": brand,
    "sku": sku,
    "weight": weight,
    "dimensions": (dimensions as DimensionsModel).toJson(),
    "warrantyInformation": warrantyInformation,
    "shippingInformation": shippingInformation,
    "availabilityStatus": availabilityStatus,
    "reviews": List<dynamic>.from(reviews.map((x) => (x as ReviewModel).toJson())),
    "returnPolicy": returnPolicy,
    "minimumOrderQuantity": minimumOrderQuantity,
    "meta": (meta as MetaModel).toJson(),
    "thumbnail": thumbnail,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}

class DimensionsModel extends Dimensions {
  DimensionsModel({
    required super.width,
    required super.height,
    required super.depth,
  });

  factory DimensionsModel.fromJson(Map<String, dynamic> json) =>
      DimensionsModel(
        width: json["width"]?.toDouble() ?? 0.0,
        height: json["height"]?.toDouble() ?? 0.0,
        depth: json["depth"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
    "width": width,
    "height": height,
    "depth": depth,
  };
}

class MetaModel extends Meta {
  MetaModel({
    required super.createdAt,
    required super.updatedAt,
    required super.barcode,
    required super.qrCode,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.now(),
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    barcode: json["barcode"] ?? '',
    qrCode: json["qrCode"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "barcode": barcode,
    "qrCode": qrCode,
  };
}

class ReviewModel extends Review {
  ReviewModel({
    required super.rating,
    required super.comment,
    required super.date,
    required super.reviewerName,
    required super.reviewerEmail,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    rating: json["rating"],
    comment: json["comment"],
    date: DateTime.parse(json["date"]),
    reviewerName: json["reviewerName"],
    reviewerEmail: json["reviewerEmail"],
  );

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "comment": comment,
    "date": date.toIso8601String(),
    "reviewerName": reviewerName,
    "reviewerEmail": reviewerEmail,
  };
}
