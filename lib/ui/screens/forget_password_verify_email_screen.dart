import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_ostad/ui/screens/forget_password_verify_otp_screen.dart';
import 'package:task_manager_ostad/ui/utills/app_colors.dart';
import 'package:task_manager_ostad/ui/widgets/screen_background.dart';

class ForgetPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgetPasswordVerifyEmailScreen({super.key});
  static const String name = '/forget-password-verify';

  @override
  State<ForgetPasswordVerifyEmailScreen> createState() =>
      _ForgetPasswordVerifyEmailScreenState();
}

class _ForgetPasswordVerifyEmailScreenState
    extends State<ForgetPasswordVerifyEmailScreen> {
  final TextEditingController _emailTEController = TextEditingController();
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
                    'Your Email Address',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                   Text(
                    'A 6 digits verification OTP will be sent to your email address',
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _emailTEController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgetPasswordVerifyOtpScreen.name);
                    },
                    child: const Icon(Icons.arrow_circle_right_outlined),
                  ),
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
                  Navigator.pop(context);
                },
            ),
          ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
  }
}
