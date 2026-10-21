import 'package:ecommerce_app_huma_volve/core/consts/api_endpoints.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_res_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/sign_up/models/signup_req_model.dart';

class SignupService {
  ApiClient apiClient;
  SignupService(this.apiClient);
  Future<SignupResModel> signup({required SignupReqModel signupReqModel}) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.signupEndpoint,
      data: {
        "avatar": "https://api.lorem.space/image/face?w=640&h=480",
        "email": signupReqModel.email,
        "name": signupReqModel.name,
        "password": signupReqModel.password,
      },
    );
    final data = response.data;
    final modelData = SignupResModel.fromJson(data);
    return modelData;
  }
}
