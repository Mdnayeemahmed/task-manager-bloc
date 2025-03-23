part of 'user_management_cubit.dart';

class UserManagementState extends Equatable {
  final UserModel? user;

  const UserManagementState({this.user});

  const UserManagementState.initial() : user = null;

  UserManagementState copyWith({UserModel? user}) {
    return UserManagementState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [user];
}
