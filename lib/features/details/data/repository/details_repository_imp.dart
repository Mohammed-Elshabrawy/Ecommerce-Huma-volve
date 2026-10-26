import 'package:dartz/dartz.dart';
import '../../../../core/error/error_handling.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/product_details_entity.dart';
import '../../domain/repository/details_repository.dart';
import '../data_source/details_remote_data_source.dart';

class DetailsRepositoryImp implements DetailsRepository {
  final DetailsRemoteDataSource detailsRemoteDataSource;

  DetailsRepositoryImp(this.detailsRemoteDataSource);

  @override
  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(
      int productId) async {
    try {
      final productDetails =
          await detailsRemoteDataSource.getProductDetails(productId);
      return Right(productDetails);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
