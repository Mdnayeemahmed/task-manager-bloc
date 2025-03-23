import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/sign_in_screen.dart';
import 'package:task_manager_ostad/feature/dashboard/presentation/ui/main_bottom_nav_screen.dart';
import '../../../../../app/app_router.dart';
import '../../../../../app/service_locator.dart';
import '../../../../common/presentation/widgets/app_logo.dart';
import '../../../../common/presentation/widgets/screen_background.dart';
import '../../blocs/splash_screen_cubit.dart';

class SplashScreen extends StatelessWidget {
  static const String name = '/';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(sl())..checkAuthentication(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashAuthenticated) {
             AppRouter.replace(context, MainBottomNavScreen.name);
          } else if (state is SplashUnauthenticated) {
            AppRouter.go(context, SignInScreen.name);
          }
        },
        child: const Scaffold(
          body: ScreenBackground(
            child: Center(
              child: AppLogo(),
            ),
          ),
        ),
      ),
    );
  }
}
