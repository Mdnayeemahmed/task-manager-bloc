import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/sign_up_screen.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/forget_password_verify_email_screen.dart';
import 'package:task_manager_ostad/feature/dashboard/presentation/ui/main_bottom_nav_screen.dart';

import '../../../../../app/app_router.dart';
import '../../../../../app/service_locator.dart';
import '../../../../../app/styling/app_colors.dart';
import '../../../../../core/widgets/responsive_layout.dart';
import '../../../../common/presentation/widgets/center_circular_progress_indicator.dart';
import '../../../../common/presentation/widgets/screen_background.dart';
import '../../../../common/presentation/widgets/snack_message.dart';
import '../../blocs/log_in_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LogInCubit _logInBloc;

  @override
  void initState() {
    super.initState();
    _logInBloc = LogInCubit(sl(), sl());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: ScreenBackground(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => _logInBloc,
            ),
          ],
          child: ResponsiveLayout(
            // desktop: _buildLoginDesktopWidget(),
            mobile:         SingleChildScrollView(
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
                        'Get Started With',
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
                            return 'Enter a valid email address';
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
                            return 'Enter your valid password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),


                      _buildLoginButton(),
                      const SizedBox(
                        height: 48,
                      ),
                      Center(
                        child: Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  AppRouter.navigateTo(context, ForgetPasswordVerifyEmailScreen.name);
                                },
                                child: const Text(
                                  'Forget Password ?',
                                  style: TextStyle(color: Colors.black45),
                                )),
                            _buildSignUp()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ), desktop: SizedBox(),

          ),
        ),
      ));





  }

  Widget _buildLoginButton() {
    return BlocConsumer<LogInCubit, LogInState>(
      listener: (context, state) {
        if (state is LogInInSuccessState) {
          _onLogInSuccess(state);
        } else if (state is LogInFailureState) {
          showSnackMessage(
              message: state.error,
              context: context,
              type: SnackMessageType.error);
        }
      },
      builder: (context, state) {
        if (state is LogInLoadingState) {
          return const CenterCircularProgressIndicator();
        }
        return ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<LogInCubit>().userSignIn(
                userEmail: _emailTEController.text.trim(),
                password: _passwordTEController.text,
              );
            }
          },
          child: const Icon(Icons.arrow_circle_right_outlined),
        );
      },
    );
  }

  // void _onTabSignInButton() {
  //   if (_formKey.currentState!.validate()) {
  //     _signInUser();
  //   }
  // }

  // Future<void> _signInUser() async {
  //   _signInProgress = true;
  //   setState(() {});
  //
  //   Map<String, dynamic> requestBody = {
  //     "email": _emailTEController.text.trim(),
  //     "password": _passwordTEController.text,
  //   };
  //
  //   final NetworkResponse response =
  //       await NetworkCaller.postRequest(url: Urls.signInUrl, body: requestBody);
  //
  //   if (response.isSuccess) {
  //     String token = response.responseData!['token'];
  //     UserModel userModel = UserModel.fromJson(response.responseData!['data']);
  //     await AuthController.saveUserData(token, userModel);
  //     Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
  //   } else {
  //     _signInProgress = false;
  //     setState(() {});
  //     if (response.statusCode == 401) {
  //       showSnackBarMessage(context, 'Email/Password is invalid! try again');
  //     } else {
  //       showSnackBarMessage(context, response.errorMessage);
  //     }
  //   }
  // }

  // void _clearTextField() {
  //   _emailTEController.clear();
  //   _passwordTEController.clear();
  // }

  RichText _buildSignUp() {
    return RichText(
      text: TextSpan(
          text: "Don't have an account? ",
          style: const TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: 'Sign up',
              style: const TextStyle(
                  color: themeColor, fontStyle: FontStyle.italic),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  AppRouter.navigateTo(context, SignUpScreen.name);

                  // AppRouter.go(context, SignUpScreen.name);

                },
            ),
          ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordTEController.dispose();
    _emailTEController.dispose();
  }

  _onLogInSuccess(LogInInSuccessState state) {
    showSnackMessage(message: "Success", context: context);
    AppRouter.replace(context, MainBottomNavScreen.name);
    _passwordTEController.clear();
    _emailTEController.clear();
  }
}
