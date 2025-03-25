import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_ostad/app/app_router.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/sign_in_screen.dart';
import '../../../../../app/service_locator.dart';
import '../../../../../app/styling/app_colors.dart';
import '../../../../common/presentation/widgets/center_circular_progress_indicator.dart';
import '../../../../common/presentation/widgets/screen_background.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/presentation/widgets/snack_bar_message.dart';
import '../../blocs/reset_password_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen( this.email, this.otp, {super.key});
  static const String name = '/reset-password';
  final String email;
  final String otp;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController =
  TextEditingController();
  final TextEditingController _confirmPasswordTEController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ResetPasswordCubit _resetPasswordBloc;
  @override
  void initState() {
    super.initState();
    _resetPasswordBloc = ResetPasswordCubit(sl());
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (_) => _resetPasswordBloc, // Initialize the Cubit
),
  ],
  child: Scaffold(
        body: ScreenBackground(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      'Set Password',
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Minimum length password 8 character with letter and number combination',
                      style: textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _newPasswordTEController,
                      decoration: const InputDecoration(
                        hintText: 'New Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return 'enter new password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _confirmPasswordTEController,
                      decoration: const InputDecoration(
                        hintText: 'Confirm Password',
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return "enter confirm password";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
                      listener: (context, state) {
                        if (state is ResetPasswordInSuccessState) {
                          showSnackBarMessage(context, 'Password change successful');
                          AppRouter.push(context, SignInScreen.name);
                        } else if (state is ResetPasswordFailureState) {
                          showSnackBarMessage(context, state.error);
                        }
                      },
                      builder: (context, state) {
                        if (state is ResetPasswordLoadingState) {
                          return const CenterCircularProgressIndicator();
                        }
                        return ElevatedButton(
                          onPressed: () {
                            _onTapResetButton(context);
                          },
                          child: const Text('Confirm'),
                        );
                      },
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
      ),
);
  }

  void _onTapResetButton(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _resetPassword(context);
    }
  }

  void _resetPassword(BuildContext context) {
    if (_newPasswordTEController.text == _confirmPasswordTEController.text) {
      context.read<ResetPasswordCubit>().userPasswordReset(
        widget.email.toString(),
        widget.otp.toString(),
        _confirmPasswordTEController.text,
      );
    } else {
      showSnackBarMessage(context, "Passwords don't match");
    }
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
                AppRouter.push(context, SignInScreen.name);
                },
            ),
          ]),
    );
  }
}

