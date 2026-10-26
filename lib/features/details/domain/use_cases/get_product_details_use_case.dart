import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/product_details_entity.dart';
import '../repository/details_repository.dart';

class GetProductDetailsUseCase {
  final DetailsRepository detailsRepository;

  GetProductDetailsUseCase(this.detailsRepository);

  Future<Either<Failure, ProductDetailsEntity>> invoke(int productId) =>
      detailsRepository.getProductDetails(productId);
}
