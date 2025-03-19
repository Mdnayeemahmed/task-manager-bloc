import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/presentation/blocs/global_auth_cubit.dart';
import '../../data/repositories/auth_repository.dart';
import '../../domain/entites/user.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository authRepository;

  ResetPasswordCubit(this.authRepository) : super(ResetPasswordInitialState());


  Future<void> userPasswordReset(String userEmail,String otp,String password) async {
    emit(ResetPasswordLoadingState());

    final result = await authRepository.resetPassword(userEmail,otp,password);

    result.fold(
          (failure) {
        emit(ResetPasswordFailureState(failure.message));
      },
          (success) {
        if (success) {
          emit(const ResetPasswordInSuccessState());
        } else {
          emit(const ResetPasswordFailureState('Reset Password failed.'));
        }
      },
    );
  }


}