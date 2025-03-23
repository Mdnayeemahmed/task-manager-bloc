import 'package:go_router/go_router.dart';
import 'package:task_manager_ostad/feature/dashboard/presentation/ui/main_bottom_nav_screen.dart';

class DashboardRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      path: MainBottomNavScreen.name,
      name: MainBottomNavScreen.name,
      builder: (context, state) {
        return  const MainBottomNavScreen();
      },
    ),

  ];
}