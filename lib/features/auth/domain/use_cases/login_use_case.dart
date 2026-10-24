import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/auth_tokens_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthTokensEntity>> invoke({
    required String email,
    required String password,
  }) => repository.login(email: email, password: password);
}
