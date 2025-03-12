import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/data/repositories/auth_repository.dart';

part 'auth_states.dart';

class GlobalAuthCubit extends Cubit<AuthState> {
  GlobalAuthCubit(this.authRepository) : super(AuthInitialState());

  final AuthRepository authRepository;

  static String accessToken = '';
  static String refreshToken = '';

  Future<void> initialize() async {
    final access = await authRepository.getUserAccessToken();
    final refresh = await authRepository.getRefreshToken();
    if (access != null) {
      accessToken = access;
    }
    if (refresh != null) {
      refreshToken = refresh;
    }
    emit(AuthVerifiedState());
  }

  Future<void> logout() async {
    await authRepository.clearUserData();
    accessToken = '';
    refreshToken = '';
    print('logout called from dio');
    emit(AuthUnverifiedState());
  }

  Future<bool> checkLoggedInStatus() async {
    final token = await authRepository.getUserAccessToken();
    return token != null;
  }
}