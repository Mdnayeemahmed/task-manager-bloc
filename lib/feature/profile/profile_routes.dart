import 'package:go_router/go_router.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/sign_in_screen.dart';
import 'package:task_manager_ostad/feature/auth/presentation/ui/screens/sign_up_screen.dart';
import 'package:task_manager_ostad/feature/profile/presentation/ui/update_profile_screen.dart';

class ProfileRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      path: UpdateProfileScreen.name,
      name: UpdateProfileScreen.name,
      builder: (context, state) {
        return  const UpdateProfileScreen();
      },
    ),
  ];
}