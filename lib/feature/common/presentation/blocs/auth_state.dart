part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final UserModel? user;

  const AuthState({this.user});

  const AuthState.initial() : user = null;

  AuthState copyWith({UserModel? user}) {
    return AuthState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];
}
