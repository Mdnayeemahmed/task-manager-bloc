part of 'otp_verify_cubit.dart';

abstract class OtpVerifyState extends Equatable {
  const OtpVerifyState();

  @override
  List<Object> get props => [];
}

class OtpVerifyInitialState extends OtpVerifyState {}

class OtpVerifyLoadingState extends OtpVerifyState {}

class OtpVerifyFailureState extends OtpVerifyState {
  const OtpVerifyFailureState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

class OtpVerifySuccessState extends OtpVerifyState {
  const OtpVerifySuccessState();

  @override
  List<Object> get props => [];
}
