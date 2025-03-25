import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_ostad/feature/auth/data/repositories/auth_local_data_source.dart';
import 'package:task_manager_ostad/feature/auth/domain/entites/user.dart';
import 'package:task_manager_ostad/core/domain/data/model/api_failure.dart';

import '../../../../core/domain/entities/failure.dart';
import '../../../auth/data/repositories/auth_repository.dart';
part 'update_profile_state.dart';


class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository _authRepository;
  final AuthLocalDataSource _authLocalDataSource;
  final ImagePicker _picker = ImagePicker();

  ProfileCubit(this._authRepository, this._authLocalDataSource)
      : super(ProfileInitial());

  /// Method to pick an image and update state accordingly
  // Future<void> pickImage() async {
  //   emit(ImagePickerLoading());
  //   try {
  //     XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       print(image.path);
  //       emit(ImagePickerPicked(image));
  //     } else {
  //       // If the user cancels picking an image, you might want to return to an initial state
  //       emit(ImagePickerInitial());
  //     }
  //   } catch (error) {
  //     emit(ImagePickerError(error.toString()));
  //   }
  // }

  Future<void> loadUserProfile() async {
    emit(ProfileLoadInProgress());
    try {
      final userData = await _authLocalDataSource.getUserInformation();
      log("called");
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






// class ProfileCubit extends Cubit<ProfileState> {
//   final AuthRepository _authRepository;
//   final AuthLocalDataSource _authLocalDataSource;
//   final ImagePicker _picker = ImagePicker();
//
//
//   ProfileCubit(this._authRepository,this._authLocalDataSource) : super(ProfileInitial());
//
//
//   Future<void> pickImage() async {
//     XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       emit(image); // Emits the new picked image state
//     }}
//
//   Future<void> loadUserProfile() async {
//     emit(ProfileLoadInProgress());
//     try {
//       final userData = await _authLocalDataSource.getUserInformation();
//       log("called");
//
//       // Check if the userData is valid or not
//       if (userData != null) {
//         emit(ProfileLoaded(userData));
//         log("success");
//       } else {
//         emit(ProfileLoadFailureFromLocal("error"));
//       }
//     } catch (error) {
//       emit(ProfileLoadFailureFromLocal(error.toString()));
//     }
//   }
//
//
//   Future<void> updateProfile({
//     required String email,
//     required String firstName,
//     required String lastName,
//     required String mobile,
//     String? password,
//     String? photo,
//   }) async {
//     emit(ProfileUpdateInProgress());
//     final result = await _authRepository.updateProfile(
//       email: email,
//       firstName: firstName,
//       lastName: lastName,
//       mobile: mobile,
//       password: password,
//       photo: photo,
//     );
//     result.fold(
//           (failure) => emit(ProfileUpdateFailure(failure)),
//           (success) => emit(ProfileUpdateSuccess()),
//     );
//   }
// }


