import '../../domain/entities/home_category_entity.dart';
import '../../domain/entities/home_product_entity.dart';
import 'category_model.dart';

class HomeProductModel extends HomeProductEntity {
  final String? creationAt;
  final String? updatedAt;

  const HomeProductModel({
    super.id,
    super.title,
    super.slug,
    super.price,
    super.description,
    super.category,
    super.images,
    this.creationAt,
    this.updatedAt,
  });

  factory HomeProductModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return HomeProductModel(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        slug: json['slug'] ?? '',
        price: json['price'] ?? 0,
        description: json['description'] ?? '',
        category: json['category'] != null
            ? HomeCategoryModel.fromJson(json['category'])
            : const HomeCategoryEntity(),
        images: json['images'] != null ? List<String>.from(json['images']) : const [],
        creationAt: json['creationAt'],
        updatedAt: json['updatedAt'],
      );
    }
    return const HomeProductModel();
  }
}
