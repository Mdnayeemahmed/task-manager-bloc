import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager_ostad/feature/auth/data/models/user_model.dart';

import '../../../auth/data/repositories/auth_local_data_source.dart';
import '../../../auth/domain/entites/user.dart';

part 'user_management_state.dart';


class UserManagementCubit extends Cubit<UserManagementState> {
  final AuthLocalDataSource _authLocalDataSource;

  UserManagementCubit(this._authLocalDataSource) : super(userProfileInitial());

  Future<void> loadUserProfile() async {
    emit(userProfileLoadInProgress());
    try {
      final userData = await _authLocalDataSource.getUserInformation();
      log("called");

      // Check if the userData is valid or not
      if (userData != null) {
        emit(userProfileLoaded(userData));
        log("success");
      } else {
        emit(userProfileLoadFailureFromLocal("error"));
      }
    } catch (error) {
      emit(userProfileLoadFailureFromLocal(error.toString()));
    }
  }


  Future<void> logout() async {
    await _authLocalDataSource.clearUserData();
  }
}



// class UserManagementCubit extends Cubit<UserManagementState> {
//   final AuthLocalDataSource _authLocalDataSource;
//
//   UserManagementCubit(this._authLocalDataSource) : super(const UserManagementState());
//
//   /// Load user information from local storage
//   Future<void> loadUser() async {
//     final userData = await _authLocalDataSource.getUserData();
//     if (userData != null) {
//       // Assume that userModel is stored under the key "userModel"
//       emit(state.copyWith(user: userData['userModel']));
//     }
//   }
//
//   /// Clear user data (for logout, etc.)
//
// }
