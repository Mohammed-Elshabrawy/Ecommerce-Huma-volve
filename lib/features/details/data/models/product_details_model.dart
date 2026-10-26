import '../../domain/entities/product_details_entity.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  final String? creationAt;
  final String? updatedAt;

  const ProductDetailsModel({
    super.id,
    super.title,
    super.slug,
    super.price,
    super.description,
    super.images,
    this.creationAt,
    this.updatedAt,
  });

  factory ProductDetailsModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      List<String> parsedImages = [];
      if (json['images'] != null && json['images'] is List) {
        for (var item in json['images']) {
          if (item is String) {
            final cleaned = item
                .replaceAll('[', '')
                .replaceAll(']', '')
                .replaceAll('"', '')
                .replaceAll('\\', '')
                .trim();
            if (cleaned.startsWith('http')) {
              parsedImages.add(cleaned);
            }
          }
        }
      }
      return ProductDetailsModel(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        slug: json['slug'] ?? '',
        price: json['price'] ?? 0,
        description: json['description'] ?? '',
        images: parsedImages,
        creationAt: json['creationAt'],
        updatedAt: json['updatedAt'],
      );
    }
    return const ProductDetailsModel();
  }
}
