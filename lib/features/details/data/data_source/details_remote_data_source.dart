import '../models/product_details_model.dart';

abstract class DetailsRemoteDataSource {
  Future<ProductDetailsModel> getProductDetails(int productId);
}
