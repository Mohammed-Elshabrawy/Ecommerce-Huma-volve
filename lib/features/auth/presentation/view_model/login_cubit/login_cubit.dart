import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/auth_tokens_entity.dart';
import '../../../domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  void login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await loginUseCase.invoke(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(LoginError(failure.failureMessage)),
      (tokens) => emit(LoginSuccess(tokens)),
    );
  }
}
