import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_ostad/app/router_error_screen.dart';

import '../feature/auth/presentation/auth_routes.dart';
import '../feature/auth/presentation/ui/screens/spiash_screen.dart';
import '../feature/common/presentation/screen/theme_demo_screen.dart';


class AppRouter {
  AppRouter._();

  static GoRouter get router => _router;

  static final GlobalKey<NavigatorState> globalKey =
  GlobalKey<NavigatorState>();

  static final _router = GoRouter(
    initialLocation: SplashScreen.name,
    navigatorKey: globalKey,
    routes: [
      GoRoute(
          path: ThemeDemoScreen.name,
          builder: (context, state) {
            return const ThemeDemoScreen();
          }),
      ...AuthRoutes.routes,
      // ...MainMenuRoutes.routes,
      // ...DashboardRoutes.routes,
    ],
    errorBuilder: (context, state) {
      return RouteErrorScreen(
        message: state.error.toString(),
      );
    },
  );

  static void go(BuildContext context, String name,
      {Map<String, String> pathParameters = const <String, String>{},
        Map<String, dynamic> queryParameters = const <String, dynamic>{},
        Object? extra}) {
    context.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  static void replace(BuildContext context, String name,
      {Map<String, String> pathParameters = const <String, String>{},
        Map<String, dynamic> queryParameters = const <String, dynamic>{},
        Object? extra}) {
    context.replaceNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }

  static void push(BuildContext context, String name, {Object? extra}) {
    context.push(name, extra: extra);
  }

  static void pop(BuildContext context, {Object? result}) {
    context.pop(result);
  }
}