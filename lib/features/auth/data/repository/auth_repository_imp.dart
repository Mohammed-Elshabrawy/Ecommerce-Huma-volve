import 'package:dartz/dartz.dart';
import '../../../../core/error/error_handling.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entities/auth_tokens_entity.dart';
import '../../domain/entities/auth_user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_remote_data_source.dart';
import '../models/signup_req_model.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImp(this.remoteDataSource);

  @override
  Future<Either<Failure, AuthTokensEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final loginModel = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(loginModel);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, AuthUserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.signUp(
        signupReqModel: SignupReqModel(
          name: name,
          email: email,
          password: password,
        ),
      );
      return Right(userModel);
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
