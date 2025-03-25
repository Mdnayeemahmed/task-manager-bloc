import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../app/app_router.dart';
import '../../../../../app/service_locator.dart';
import '../../../../../app/styling/app_colors.dart';
import '../../../../common/presentation/widgets/center_circular_progress_indicator.dart';
import '../../../../common/presentation/widgets/screen_background.dart';
import '../../../../common/presentation/widgets/snack_bar_message.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../blocs/forgot_password_verify_email_cubit.dart';
import 'forget_password_verify_otp_screen.dart';

class ForgetPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgetPasswordVerifyEmailScreen({super.key});

  static const String name = '/forget-password-verify';

  @override
  State<ForgetPasswordVerifyEmailScreen> createState() => _ForgetPasswordVerifyEmailScreenState();
}

class _ForgetPasswordVerifyEmailScreenState extends State<ForgetPasswordVerifyEmailScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ForgotPasswordCubit _forgotPassBloc;
  @override
  void initState() {
    super.initState();
    _forgotPassBloc = ForgotPasswordCubit(sl());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => _forgotPassBloc, // Provide the cubit
),
  ],
  child: Scaffold(
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key:_formKey,
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
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocConsumer<ForgotPasswordCubit, ForgotPasswordVerifyEmailState>(
                      listener: (context, state) {
                        if (state is ForgotPasswordVerifyEmailFailureState) {
                          showSnackBarMessage(context, state.error);
                        }
                        if (state is ForgotPasswordVerifyEmailSuccessState) {
                          AppRouter.replace(
                            context,
                            ForgetPasswordVerifyOtpScreen.name,
                            extra:_emailTEController.text

                          );


                          // AppRouter.replace(context, ForgetPasswordVerifyOtpScreen.name);
                          //
                          // AppRoutes.
                          //
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ForgetPasswordVerifyOtpScreen(
                          //       email: _emailTEController.text,
                          //     ),
                          //   ),
                          // );
                        }
                      },
                      builder: (context, state) {
                        if (state is ForgotPasswordVerifyEmailLoadingState) {
                          return const CenterCircularProgressIndicator();
                        }

                        return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final cubit = context.read<ForgotPasswordCubit>();
                              cubit.verifyEmail(_emailTEController.text);
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Center(
                      child: _buildSignUp(context),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
);
  }

  Widget _buildSignUp(BuildContext context) {
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
                Navigator.pop(context);
              },
          ),
        ],
      ),
    );
  }
}
