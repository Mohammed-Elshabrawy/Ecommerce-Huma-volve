import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/auth_user_entity.dart';
import '../../../domain/use_cases/sign_up_use_case.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpCubit({required this.signUpUseCase}) : super(SignUpInitial());

  void signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    final result = await signUpUseCase.invoke(
      name: name,
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(SignUpError(failure.failureMessage)),
      (user) => emit(SignUpSuccess(user)),
    );
  }
}
