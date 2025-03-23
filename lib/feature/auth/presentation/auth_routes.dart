import 'package:go_router/go_router.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/forget_password_verify_email_screen.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/reset_password_screen.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/sign_in_screen.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/sign_up_screen.dart';
import 'ui/screens/spiash_screen.dart';

class AuthRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      path: SplashScreen.name,
      name: SplashScreen.name,
      builder: (context, state) {
        return  const SplashScreen();
      },
    ),
    GoRoute(
      path: SignUpScreen.name,
      name: SignUpScreen.name,
      builder: (context, state) {
        return  const SignUpScreen();
      },
    ),
    GoRoute(
      path: ResetPasswordScreen.name,
      name: ResetPasswordScreen.name,
      builder: (context, state) {
        return  const ResetPasswordScreen();
      },
    ),
    GoRoute(
      path: ForgetPasswordVerifyEmailScreen.name,
      name: ForgetPasswordVerifyEmailScreen.name,
      builder: (context, state) {
        return  const ForgetPasswordVerifyEmailScreen();
      },
    ),
    GoRoute(
      path: SignInScreen.name,
      name: SignInScreen.name,
      builder: (context, state) {
        return  const SignInScreen();
      },
    ),
    // GoRoute(
    //   path: SignUpScreen.name,
    //   name: SignUpScreen.name,
    //   builder: (context, state) {
    //     return  const SignUpScreen();
    //   },
    // ),
  ];
}