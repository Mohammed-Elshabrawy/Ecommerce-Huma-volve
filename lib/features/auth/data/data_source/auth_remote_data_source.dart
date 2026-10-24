import '../models/login_model.dart';
import '../models/signup_req_model.dart';
import '../models/signup_res_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login({
    required String email,
    required String password,
  });

  Future<SignupResModel> signUp({
    required SignupReqModel signupReqModel,
  });
}
