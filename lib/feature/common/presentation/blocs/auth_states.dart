part of 'global_auth_cubit.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthVerifiedState extends AuthState {}

class AuthUnverifiedState extends AuthState {}