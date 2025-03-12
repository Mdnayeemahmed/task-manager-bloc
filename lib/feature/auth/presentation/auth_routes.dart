import 'package:go_router/go_router.dart';


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
      path: LoginScreen.name,
      name: LoginScreen.name,
      builder: (context, state) {
        return  const LoginScreen();
      },
    ),

    // GoRoute(
    //   path: ProductDataTableWidget.name,
    //   name: ProductDataTableWidget.name,
    //   builder: (context, state) {
    //     return ProductDataTableWidget();
    //   },
    // ),
  ];
}