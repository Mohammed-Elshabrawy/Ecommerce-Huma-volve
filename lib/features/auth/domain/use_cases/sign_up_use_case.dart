import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/auth_user_entity.dart';
import '../repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, AuthUserEntity>> invoke({
    required String name,
    required String email,
    required String password,
  }) => repository.signUp(name: name, email: email, password: password);
}
