part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpFailureState extends SignUpState {
  const SignUpFailureState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class SignUpSuccessState extends SignUpState {
  const SignUpSuccessState(this.userData);

  final User userData;

  @override
  List<Object> get props => [userData];
}