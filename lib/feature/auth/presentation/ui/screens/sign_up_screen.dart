import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../app/app_router.dart';
import '../../../../../app/service_locator.dart';
import '../../../../../app/styling/app_colors.dart';
import '../../../../common/presentation/widgets/center_circular_progress_indicator.dart';
import '../../../../common/presentation/widgets/screen_background.dart';
import '../../../../common/presentation/widgets/snack_bar_message.dart';
import '../../blocs/sign_up_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SignUpCubit _signUpBloc;
  @override
  void initState() {
    super.initState();
    _signUpBloc = SignUpCubit(sl());
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => _signUpBloc,
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
                      'Join With Us',
                      style: textTheme.titleLarge,
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
                          return 'Enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: const InputDecoration(
                        hintText: 'First Name',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your first name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: const InputDecoration(
                        hintText: 'Last Name',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _mobileTEController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Mobile',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your mobile number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your password';
                        }
                        if (value!.length < 6) {
                          return 'Enter a password more than 6 letters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocConsumer<SignUpCubit, SignUpState>(
                      listener: (context, state) {
                        if (state is SignUpFailureState) {
                          showSnackBarMessage(context, state.error);
                        }
                        if (state is SignUpSuccessState) {
                          showSnackBarMessage(context, "Sign-up successful!");
                          AppRouter.pop(context);

                        }
                      },
                      builder: (context, state) {
                        return Visibility(
                          visible: !(state is SignUpLoadingState),
                          replacement: const CenterCircularProgressIndicator(),
                          child: ElevatedButton(
                            onPressed: (){

                              _onTapSignUpButton(context);
                            },

                            child: const Icon(Icons.arrow_circle_right_outlined),
                          ),
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

  void _onTapSignUpButton(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _signUpUser(context);
    }
  }

  Future<void> _signUpUser(BuildContext context) async {
    context.read<SignUpCubit>().userSignUp(
      userEmail: _emailTEController.text.trim(),
      firstName: _firstNameTEController.text.trim(),
      lastName: _lastNameTEController.text.trim(),
      mobile: _mobileTEController.text.trim(),
      password: _passwordTEController.text,
    );
  }

  RichText _buildSignUp() {
    return RichText(
      text: TextSpan(
        text: "Already have an account? ",
        style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(color: themeColor, fontStyle: FontStyle.italic),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pop(context);
              },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordTEController.dispose();
    _emailTEController.dispose();
  }
}
