import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_ostad/app/app_router.dart';
import 'package:task_manager_ostad/data/service/network_caller.dart';
import 'package:task_manager_ostad/data/utills/urls.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/reset_password_screen.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/sign_in_screen.dart';

import '../../../../../app/service_locator.dart';
import '../../../../../app/styling/app_colors.dart';
import '../../../../common/presentation/widgets/center_circular_progress_indicator.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/presentation/widgets/snack_bar_message.dart';
import '../../blocs/otp_verify_cubit.dart';

class ForgetPasswordVerifyOtpScreen extends StatefulWidget {
  const ForgetPasswordVerifyOtpScreen({super.key, this.email, this.otp});
  final String? email;
  final String? otp;
  static const String name = '/forget-password-verify-otp';

  @override
  State<ForgetPasswordVerifyOtpScreen> createState() =>
      _ForgetPasswordVerifyOtpScreenState();
}

class _ForgetPasswordVerifyOtpScreenState
    extends State<ForgetPasswordVerifyOtpScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _otpVerifyInProgress = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocProvider(
        create: (context) => OtpVerifyCubit(sl()), // Provide the cubit
        child: BlocListener<OtpVerifyCubit, OtpVerifyState>(
          listener: (context, state) {
            if (state is OtpVerifyLoadingState) {
              setState(() {
                _otpVerifyInProgress = true;
              });
            } else {
              setState(() {
                _otpVerifyInProgress = false;
              });
            }

            if (state is OtpVerifySuccessState) {
              AppRouter.push(
                  context,
                  ResetPasswordScreen.name,
                  extra: [widget.email, _otpTEController.text]
              );
              showSnackBarMessage(context, 'OTP Verified Successfully');
            } else if (state is OtpVerifyFailureState) {
              showSnackBarMessage(context, state.error);
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      'OTP Verification',
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'A 6 digits verification OTP has been sent to your email address',
                      style: textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    _buildPinCodeTextField(),
                    const SizedBox(
                      height: 16,
                    ),
                    Visibility(
                      visible: !_otpVerifyInProgress,
                      replacement: const CenterCircularProgressIndicator(),
                      child: ElevatedButton(
                        onPressed: () {
                          _onTapOtpVerifyButton(context); // Pass context for cubit
                        },
                        child: const Text('Verify'),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Center(
                      child: _buildSignUp(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapOtpVerifyButton(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = widget.email ?? '';
      final otp = _otpTEController.text;

      // Call the cubit to verify OTP
      context.read<OtpVerifyCubit>().verifyOtp(email, otp);
    }
  }

  Widget _buildPinCodeTextField() {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        inactiveColor: Colors.blue,
        selectedColor: Colors.blue,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      controller: _otpTEController,
      appContext: context,
    );
  }

  Widget _buildSignUp() {
    return RichText(
      text: TextSpan(
          text: "Already have an account? ",
          style: const TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: 'Sign In',
              style: const TextStyle(
                  color: themeColor, fontStyle: FontStyle.italic),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                AppRouter.go(context, SignInScreen.name);
                },
            ),
          ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _otpTEController.dispose();
  }
}

