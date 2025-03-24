part of 'user_management_cubit.dart';

// class UserManagementState extends Equatable {
//   final UserModel? user;
//
//   const UserManagementState({this.user});
//
//   const UserManagementState.initial() : user = null;
//
//   UserManagementState copyWith({UserModel? user}) {
//     return UserManagementState(
//       user: user ?? this.user,
//     );
//   }
//
//   @override
//   List<Object?> get props => [user];
// }
abstract class UserManagementState {}

class userProfileInitial extends UserManagementState {}

class userProfileLoadInProgress extends UserManagementState {}

class userProfileLoaded extends UserManagementState {
  final User user;
  userProfileLoaded(this.user);

}
class userProfileLoadFailureFromLocal extends UserManagementState {
  final String? failure;
  userProfileLoadFailureFromLocal(this.failure);
}
