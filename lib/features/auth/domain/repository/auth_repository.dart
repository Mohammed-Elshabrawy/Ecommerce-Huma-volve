import 'package:dartz/dartz.dart';
import '../../../../core/failure/failure.dart';
import '../entities/auth_tokens_entity.dart';
import '../entities/auth_user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthTokensEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthUserEntity>> signUp({
    required String name,
    required String email,
    required String password,
  });
}
