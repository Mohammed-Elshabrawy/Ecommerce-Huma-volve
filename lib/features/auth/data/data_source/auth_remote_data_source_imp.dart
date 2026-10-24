import '../../../../core/consts/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/secure_storage.dart';
import '../models/login_model.dart';
import '../models/signup_req_model.dart';
import '../models/signup_res_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImp(this.apiClient);

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.loginEndpoint,
      data: {'email': email, 'password': password},
    );
    final loginModel = LoginModel.fromJson(response.data);
    if (loginModel.accessToken.isNotEmpty) {
      await SecureStorage.saveAccessToken(loginModel.accessToken);
    }
    if (loginModel.refreshToken.isNotEmpty) {
      await SecureStorage.saveRefreshToken(loginModel.refreshToken);
    }
    return loginModel;
  }

  @override
  Future<SignupResModel> signUp({
    required SignupReqModel signupReqModel,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.signupEndpoint,
      data: signupReqModel.toJson(),
    );
    return SignupResModel.fromJson(response.data);
  }
}
