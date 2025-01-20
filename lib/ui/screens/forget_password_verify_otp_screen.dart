import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_ostad/ui/screens/reset_password_screen.dart';
import 'package:task_manager_ostad/ui/screens/sign_in_screen.dart';
import 'package:task_manager_ostad/ui/utills/app_colors.dart';
import 'package:task_manager_ostad/ui/widgets/screen_background.dart';

class ForgetPasswordVerifyOtpScreen extends StatefulWidget {
  const ForgetPasswordVerifyOtpScreen({super.key});
  static const String name = '/forget-password-verify-otp';

  @override
  State<ForgetPasswordVerifyOtpScreen> createState() =>
      _ForgetPasswordVerifyOtpScreenState();
}

class _ForgetPasswordVerifyOtpScreenState
    extends State<ForgetPasswordVerifyOtpScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _globalKey,
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
                  ElevatedButton(onPressed: () {
                    Navigator.pushNamed(context, ResetPasswordScreen.name);
                  }, child: const Text('Verify')),
                  const SizedBox(
                    height: 48,
                  ),
                  Center(
                    child: _buildSignUp(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
              text: 'Sing In',
              style: const TextStyle(
                  color: AppColor.themeColor, fontStyle: FontStyle.italic),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, SignInScreen.name, (value) => false);
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
