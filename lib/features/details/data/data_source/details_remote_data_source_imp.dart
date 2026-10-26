import '../../../../core/consts/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/product_details_model.dart';
import 'details_remote_data_source.dart';

class DetailsRemoteDataSourceImp implements DetailsRemoteDataSource {
  final ApiClient apiClient;

  DetailsRemoteDataSourceImp(this.apiClient);

  @override
  Future<ProductDetailsModel> getProductDetails(int productId) async {
    final response = await apiClient.dio.get(
      '${ApiEndpoints.productEndpoint}/$productId',
    );
    return ProductDetailsModel.fromJson(response.data);
  }
}
