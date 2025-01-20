import 'package:flutter/material.dart';
import 'package:task_manager_ostad/ui/screens/add_new_task_list_screen.dart';
import 'package:task_manager_ostad/ui/screens/forget_password_verify_email_screen.dart';
import 'package:task_manager_ostad/ui/screens/forget_password_verify_otp_screen.dart';
import 'package:task_manager_ostad/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_ostad/ui/screens/reset_password_screen.dart';
import 'package:task_manager_ostad/ui/screens/sign_in_screen.dart';
import 'package:task_manager_ostad/ui/screens/sign_up_screen.dart';
import 'package:task_manager_ostad/ui/screens/spiash_screen.dart';
import 'package:task_manager_ostad/ui/screens/update_profile_screen.dart';
import 'package:task_manager_ostad/ui/utills/app_colors.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
          chipTheme:  const ChipThemeData(
            labelStyle: TextStyle(color: Colors.white),
            side: BorderSide.none,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
          ),
          colorSchemeSeed: AppColor.themeColor,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            titleSmall: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            filled: true,
            fillColor: Colors.white,
            hintStyle:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            border: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              fixedSize: const Size.fromWidth(double.maxFinite),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          )),
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == SplashScreen.name) {
          widget = const SplashScreen();
        } else if (settings.name == SignInScreen.name) {
          widget = const SignInScreen();
        } else if (settings.name == SignUpScreen.name) {
          widget = const SignUpScreen();
        } else if (settings.name == ForgetPasswordVerifyEmailScreen.name) {
          widget = const ForgetPasswordVerifyEmailScreen();
        } else if (settings.name == ForgetPasswordVerifyOtpScreen.name) {
          widget = const ForgetPasswordVerifyOtpScreen();
        } else if (settings.name == ResetPasswordScreen.name) {
          widget = const ResetPasswordScreen();
        } else if (settings.name == MainBottomNavScreen.name) {
          widget = const MainBottomNavScreen();
        } else if (settings.name == AddNewTaskListScreen.name) {
          widget = const AddNewTaskListScreen();
        } else if (settings.name == UpdateProfileScreen.name) {
          widget = const UpdateProfileScreen();
        }
        return MaterialPageRoute(builder: (context) {
          return widget;
        });
      },
    );
  }
}
