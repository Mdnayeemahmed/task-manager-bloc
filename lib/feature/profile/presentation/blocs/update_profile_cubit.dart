import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:task_manager_ostad/feature/auth/data/repositories/auth_local_data_source.dart';
import 'package:task_manager_ostad/feature/auth/domain/entites/user.dart';
import 'package:task_manager_ostad/core/domain/data/model/api_failure.dart';

import '../../../../core/domain/entities/failure.dart';
import '../../../auth/data/repositories/auth_repository.dart';
part 'update_profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository _authRepository;
  final AuthLocalDataSource _authLocalDataSource;

  ProfileCubit(this._authRepository,this._authLocalDataSource) : super(ProfileInitial());

  Future<void> loadUserProfile() async {
    emit(ProfileLoadInProgress());
    try {
      final userData = await _authLocalDataSource.getUserInformation();
      log("called");

      // Check if the userData is valid or not
      if (userData != null) {
        emit(ProfileLoaded(userData));
        log("success");
      } else {
        emit(ProfileLoadFailureFromLocal("error"));
      }
    } catch (error) {
      emit(ProfileLoadFailureFromLocal(error.toString()));
    }
  }


  Future<void> updateProfile({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    String? password,
    String? photo,
  }) async {
    emit(ProfileUpdateInProgress());
    final result = await _authRepository.updateProfile(
      email: email,
      firstName: firstName,
      lastName: lastName,
      mobile: mobile,
      password: password,
      photo: photo,
    );
    result.fold(
          (failure) => emit(ProfileUpdateFailure(failure)),
          (success) => emit(ProfileUpdateSuccess()),
    );
  }
}


