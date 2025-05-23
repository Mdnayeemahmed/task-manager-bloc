import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_manager_ostad/app/service_locator.dart';
// import 'package:task_manager_ostad/feature/new_task/presentation/ui/add_new_task_list_screen.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/forget_password_verify_email_screen.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/sign_in_screen.dart';
import 'package:task_manager_ostad/feature/common/presentation/blocs/user_management_cubit.dart';
// import 'package:task_manager_ostad/ui/screens/forget_password_verify_otp_screen.dart';
import 'package:task_manager_ostad/feature/dashboard/presentation/ui/main_bottom_nav_screen.dart';
// import 'package:task_manager_ostad/ui/screens/reset_password_screen.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/spiash_screen.dart';
import 'package:task_manager_ostad/feature/profile/presentation/ui/update_profile_screen.dart';
// import 'package:task_manager_ostad/ui/utills/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/repository/language_repository.dart';
import '../core/repository/theme_repository.dart';
import '../feature/common/presentation/blocs/global_auth_cubit.dart';
import 'app_router.dart';
import 'blocs/language_selector_cubit.dart';
import 'blocs/theme_selector_cubit.dart';


// class TaskManager extends StatefulWidget {
//   const TaskManager({super.key});
//
//   @override
//   State<TaskManager> createState() => _TaskManagerState();
// }
//
// class _TaskManagerState extends State<TaskManager> {
//   late final LanguageSelectorCubit _languageSelectorCubit;
//   late final ThemeSelectorCubit _themeSelectorCubit;
//
//   @override
//   void initState() {
//     super.initState();
//     _languageSelectorCubit = LanguageSelectorCubit(sl<LanguageRepository>());
//     _themeSelectorCubit = ThemeSelectorCubit(sl<ThemeModeRepository>());
//     _languageSelectorCubit.getPreSelectedLocale();
//     _themeSelectorCubit.getPreSelectedTheme();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider.value(value: _languageSelectorCubit),
//         BlocProvider.value(value: _themeSelectorCubit),
//         BlocProvider(create: (_) => GlobalAuthCubit(sl())),
//       ],
//       child: BlocListener<GlobalAuthCubit, AuthState>(
//         listener: (context, state) {
//           if (state is AuthUnverifiedState) {
//             AppRouter.push(
//               AppRouter.globalKey.currentContext!,
//               SignInScreen.name,
//             );
//           }
//         },
//         child: BlocBuilder<LanguageSelectorCubit, Locale>(
//           builder: (context, Locale language) {
//             return BlocBuilder<ThemeSelectorCubit, ThemeMode>(
//               builder: (context, ThemeMode themeMode) {
//                 return MaterialApp.router(
//                   title: 'SM app',
//                   locale: language,
//                   routeInformationParser:
//                   AppRouter.router.routeInformationParser,
//                   routerDelegate: AppRouter.router.routerDelegate,
//                   routeInformationProvider:
//                   AppRouter.router.routeInformationProvider,
//                   // theme: GlobalThemeData.lightTheme,
//                   // darkTheme: GlobalThemeData.darkTheme,
//                   themeMode: themeMode,
//                   supportedLocales: _languageSelectorCubit.locales,
//                   // localizationsDelegates: const [
//                   //   AppLocalizations.delegate,
//                   //   GlobalMaterialLocalizations.delegate,
//                   //   GlobalWidgetsLocalizations.delegate,
//                   //   GlobalCupertinoLocalizations.delegate,
//                   // ],
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _languageSelectorCubit.close();
//     super.dispose();
//   }
// }



// class TaskManager extends StatelessWidget {
//   const TaskManager({super.key});
//
//   static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       navigatorKey: navigatorKey,
//       theme: ThemeData(
//           colorSchemeSeed: AppColor.themeColor,
//           textTheme: const TextTheme(
//             titleLarge: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//             ),
//             titleSmall: TextStyle(
//               color: Colors.grey,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           inputDecorationTheme: const InputDecorationTheme(
//             contentPadding: EdgeInsets.symmetric(horizontal: 16),
//             filled: true,
//             fillColor: Colors.white,
//             hintStyle:
//                 TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
//             border: UnderlineInputBorder(
//               borderSide: BorderSide.none,
//             ),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide.none,
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide.none,
//             ),
//           ),
//           elevatedButtonTheme: ElevatedButtonThemeData(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColor.themeColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               fixedSize: const Size.fromWidth(double.maxFinite),
//               foregroundColor: Colors.white,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             ),
//           )),
//       onGenerateRoute: (RouteSettings settings) {
//         late Widget widget;
//         if (settings.name == SplashScreen.name) {
//           widget = const SplashScreen();
//         } else if (settings.name == SignInScreen.name) {
//           widget = const SignInScreen();
//         } else if (settings.name == SignUpScreen.name) {
//           widget = const SignUpScreen();
//         } else if (settings.name == ForgetPasswordVerifyEmailScreen.name) {
//           widget = const ForgetPasswordVerifyEmailScreen();
//         } else if (settings.name == ForgetPasswordVerifyOtpScreen.name) {
//           widget = const ForgetPasswordVerifyOtpScreen();
//         } else if (settings.name == ResetPasswordScreen.name) {
//           widget = const ResetPasswordScreen();
//         } else if (settings.name == MainBottomNavScreen.name) {
//           widget = const MainBottomNavScreen();
//         } else if (settings.name == AddNewTaskListScreen.name) {
//           widget = const AddNewTaskListScreen();
//         } else if (settings.name == UpdateProfileScreen.name) {
//           widget = const UpdateProfileScreen();
//         }
//         return MaterialPageRoute(builder: (context) {
//           return widget;
//         });
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'styling.dart'; // Import the theme file
import 'blocs/language_selector_cubit.dart';
import 'blocs/theme_selector_cubit.dart';

import 'app_router.dart'; // Make sure this provides your GoRouter instance

class TaskManager extends StatefulWidget {
  const TaskManager({Key? key}) : super(key: key);

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  late final LanguageSelectorCubit _languageSelectorCubit;
  late final ThemeSelectorCubit _themeSelectorCubit;

  @override
  void initState() {
    super.initState();
    _languageSelectorCubit = LanguageSelectorCubit(sl<LanguageRepository>());
    _themeSelectorCubit = ThemeSelectorCubit(sl<ThemeModeRepository>());
    _languageSelectorCubit.getPreSelectedLocale();
    _themeSelectorCubit.getPreSelectedTheme();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _languageSelectorCubit),
        BlocProvider.value(value: _themeSelectorCubit),
        BlocProvider(create: (_) => GlobalAuthCubit(sl())),
        // BlocProvider(create: (_) => UserManagementCubit(sl())),
      ],
      child: BlocListener<GlobalAuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthUnverifiedState) {
            // Navigate to the sign in screen using GoRouter
            context.goNamed('signIn');
          }
        },
        child: BlocBuilder<LanguageSelectorCubit, Locale>(
          builder: (context, Locale language) {
            return BlocBuilder<ThemeSelectorCubit, ThemeMode>(
              builder: (context, ThemeMode themeMode) {
                return MaterialApp.router(
                  title: 'SM app',
                  locale: language,
                  theme: lightTheme,
                  // You can also define a dark theme and pass it here:
                  // darkTheme: darkTheme,
                  themeMode: themeMode,
                  supportedLocales: _languageSelectorCubit.locales,
                  routeInformationParser:
                  AppRouter.router.routeInformationParser,
                  routerDelegate: AppRouter.router.routerDelegate,
                  routeInformationProvider:
                  AppRouter.router.routeInformationProvider,
                  // Uncomment the following lines to add localization delegates if needed:
                  // localizationsDelegates: [
                  //   AppLocalizations.delegate,
                  //   GlobalMaterialLocalizations.delegate,
                  //   GlobalWidgetsLocalizations.delegate,
                  //   GlobalCupertinoLocalizations.delegate,
                  // ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _languageSelectorCubit.close();
    _themeSelectorCubit.close();
    super.dispose();
  }
}


