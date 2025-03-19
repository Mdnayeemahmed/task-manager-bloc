import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/auth_repository.dart';
part 'otp_verify_state.dart';


class OtpVerifyCubit extends Cubit<OtpVerifyState> {

  final AuthRepository authRepository;

  OtpVerifyCubit(this.authRepository) : super(OtpVerifyInitialState());


  Future<void> verifyOtp(String userEmail,String otp) async {
    emit(OtpVerifyLoadingState());

    final result = await authRepository.verifyOtp(userEmail,otp);

    result.fold(
          (failure) {
        emit(OtpVerifyFailureState(failure.message));
      },
          (success) {
        if (success) {
          emit(const OtpVerifySuccessState());
        } else {
          emit(const OtpVerifyFailureState('Otp verification failed.'));
        }
      },
    );
  }
}
