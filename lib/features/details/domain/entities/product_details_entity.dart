import '../../../home/domain/entities/home_product_entity.dart';

class ProductDetailsEntity extends HomeProductEntity {
  const ProductDetailsEntity({
    super.id,
    super.title,
    super.slug,
    super.price,
    super.description,
    super.category,
    super.images,
  });
}
