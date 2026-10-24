import 'package:flutter/material.dart';
import 'home_category_entity.dart';

class HomeProductEntity {
  final int id;
  final String title;
  final String slug;
  final int price;
  final String description;
  final HomeCategoryEntity category;
  final List<String> images;

  const HomeProductEntity({
    this.id = 0,
    this.title = '',
    this.slug = '',
    this.price = 0,
    this.description = '',
    this.category = const HomeCategoryEntity(),
    this.images = const [],
  });

  String get name => title;

  String get imageUrl {
    if (images.isNotEmpty) {
      final rawImg = images.first
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll('"', '')
          .replaceAll('\\', '');
      if (rawImg.startsWith('http')) {
        return rawImg;
      }
    }
    return 'https://picsum.photos/seed/$id/300/300';
  }

  List<Color> get colors => const [Colors.black, Colors.blue, Colors.grey];
  List<String> get sizes => const ['S', 'M', 'L', 'XL'];
}
