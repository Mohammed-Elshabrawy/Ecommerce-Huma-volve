import '../../domain/entities/home_category_entity.dart';

class HomeCategoryModel extends HomeCategoryEntity {
  const HomeCategoryModel({super.id, super.name});

  factory HomeCategoryModel.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return HomeCategoryModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
      );
    }
    return const HomeCategoryModel();
  }
}
