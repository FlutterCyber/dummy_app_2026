import '../../domain/entity/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required super.slug,
    required super.name,
    required super.url,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    slug: json["slug"] ?? '',
    name: json["name"] ?? '',
    url: json["url"] ?? '',
  );
}
