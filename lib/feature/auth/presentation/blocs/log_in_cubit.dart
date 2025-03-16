import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/blocs/global_auth_cubit.dart';
import '../../data/repositories/auth_repository.dart';
import '../../domain/entites/user.dart';

part 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final AuthRepository authRepository;
  final GlobalAuthCubit authCubit;

  LogInCubit(this.authRepository, this.authCubit) : super(LogInInitialState());

  Future<void> userSignIn({required String userEmail, required String password}) async {
    emit(LogInLoadingState());
    final response = await authRepository.signIn(userEmail, password);
    await response.fold(
          (error) {
        emit(LogInFailureState(error.message));
      },
          (userData) async {
        await authCubit.initialize();
        emit(LogInInSuccessState(userData));
      },
    );
  }
}