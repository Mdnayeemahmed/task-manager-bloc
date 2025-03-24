// profile_update_state.dart
part of 'update_profile_cubit.dart';
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoadInProgress extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  ProfileLoaded(this.user);

}
class ProfileLoadFailureFromLocal extends ProfileState {
  final String? failure;
  ProfileLoadFailureFromLocal(this.failure);
}
class ProfileLoadFailure extends ProfileState {
  final Failure failure;
  ProfileLoadFailure(this.failure);
}

class ProfileUpdateInProgress extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {}

class ProfileUpdateFailure extends ProfileState {
  final Failure failure;
  ProfileUpdateFailure(this.failure);
}

// abstract class ProfileState {}
//
// class ProfileInitial extends ProfileState {}
//
// class ProfileUpdateInProgress extends ProfileState {}
//
// class ProfileUpdateSuccess extends ProfileState {}
//
// class ProfileUpdateFailure extends ProfileState {
//   final Failure failure;
//   ProfileUpdateFailure(this.failure);
// }
