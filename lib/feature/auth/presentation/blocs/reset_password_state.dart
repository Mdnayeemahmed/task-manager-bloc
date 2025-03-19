part of 'reset_password_cubit.dart';
abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState(); // Add the const constructor to this class.

  @override
  List<Object> get props => [];
}

class ResetPasswordInitialState extends ResetPasswordState {}

class ResetPasswordLoadingState extends ResetPasswordState {}

class ResetPasswordFailureState extends ResetPasswordState {
  const ResetPasswordFailureState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class ResetPasswordInSuccessState extends ResetPasswordState {
  const ResetPasswordInSuccessState();

  @override
  List<Object> get props => [];
}
