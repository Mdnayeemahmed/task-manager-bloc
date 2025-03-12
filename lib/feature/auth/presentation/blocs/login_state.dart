part of 'log_in_cubit.dart';

abstract class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object> get props => [];
}

class LogInInitialState extends LogInState {}

class LogInLoadingState extends LogInState {}

class LogInFailureState extends LogInState {
  const LogInFailureState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class LogInInSuccessState extends LogInState {
  const LogInInSuccessState(this.loginData);

  final Login loginData;

  @override
  List<Object> get props => [loginData];
}