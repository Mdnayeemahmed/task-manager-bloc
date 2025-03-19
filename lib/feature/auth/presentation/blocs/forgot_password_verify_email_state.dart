part of 'forgot_password_verify_email_cubit.dart';

abstract class ForgotPasswordVerifyEmailState extends Equatable {
  const ForgotPasswordVerifyEmailState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordVerifyEmailInitialState extends ForgotPasswordVerifyEmailState {}

class ForgotPasswordVerifyEmailLoadingState extends ForgotPasswordVerifyEmailState {}

class ForgotPasswordVerifyEmailFailureState extends ForgotPasswordVerifyEmailState {
  const ForgotPasswordVerifyEmailFailureState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class ForgotPasswordVerifyEmailSuccessState extends ForgotPasswordVerifyEmailState {
  const ForgotPasswordVerifyEmailSuccessState();

  @override
  List<Object> get props => [];
}
