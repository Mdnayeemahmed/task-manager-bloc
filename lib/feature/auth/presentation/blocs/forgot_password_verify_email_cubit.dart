import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/auth_repository.dart';
part 'forgot_password_verify_email_state.dart';


class ForgotPasswordCubit extends Cubit<ForgotPasswordVerifyEmailState> {

  final AuthRepository authRepository;

  ForgotPasswordCubit(this.authRepository) : super(ForgotPasswordVerifyEmailInitialState());


  Future<void> verifyEmail(String userEmail) async {
    emit(ForgotPasswordVerifyEmailLoadingState());

    final result = await authRepository.resetEmailRequest(userEmail);

    result.fold(
          (failure) {
        emit(ForgotPasswordVerifyEmailFailureState(failure.message));
      },
          (success) {
        if (success) {
          emit(const ForgotPasswordVerifyEmailSuccessState());
        } else {
          emit(const ForgotPasswordVerifyEmailFailureState('Email verification failed.'));
        }
      },
    );
  }
}
