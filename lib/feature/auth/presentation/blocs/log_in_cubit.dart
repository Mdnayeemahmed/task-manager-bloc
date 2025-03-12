import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm_app/features/auth/data/repositories/auth_repository.dart';
import 'package:sm_app/features/auth/domain/entities/login.dart';
import 'package:sm_app/features/common/common.dart';

import '../../data/repositories/auth_repository.dart';

part 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final AuthRepository authRepository;
  final GlobalAuthCubit authCubit;

  LogInCubit(this.authRepository, this.authCubit) : super(LogInInitialState());

  Future<void> userSignIn({required String userName, required String password}) async {
    emit(LogInLoadingState());
    final response = await authRepository.signIn(userName, password);
    await response.fold(
          (error) {
        emit(LogInFailureState(error.message));
      },
          (loginData) async {
        await authCubit.initialize();
        emit(LogInInSuccessState(loginData));
      },
    );
  }
}