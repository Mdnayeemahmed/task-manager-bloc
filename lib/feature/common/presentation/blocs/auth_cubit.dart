import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_manager_ostad/feature/auth/data/models/user_model.dart';

import '../../../auth/data/repositories/auth_local_data_source.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthLocalDataSource _authLocalDataSource;

  AuthCubit(this._authLocalDataSource) : super(const AuthState());

  /// Load user information from local storage
  Future<void> loadUser() async {
    final userData = await _authLocalDataSource.getUserData();
    if (userData != null) {
      // Assume that userModel is stored under the key "userModel"
      emit(state.copyWith(user: userData['userModel']));
    }
  }

  /// Clear user data (for logout, etc.)
  Future<void> logout() async {
    await _authLocalDataSource.clearUserData();
    emit(state.copyWith(user: null));
  }
}
