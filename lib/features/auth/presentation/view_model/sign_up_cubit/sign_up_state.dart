part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {
  final AuthUserEntity user;
  SignUpSuccess(this.user);
}

final class SignUpError extends SignUpState {
  final String errorMessage;
  SignUpError(this.errorMessage);
}
