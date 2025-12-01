import 'package:chat_app/src/features/auth/presentation/pages/auth/index.dart';
import 'package:chat_app/src/features/auth/presentation/pages/splash/index.dart';
import 'package:go_router/go_router.dart';

class TRouterConfig {
  TRouterConfig._();

  static const String homeRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String authRoute = "/auth";
  static const String settingsRoute = "/settings";
  static const String splashRoute = "/splash";
  static final router = GoRouter(
    initialLocation: splashRoute,
    routes: [
      GoRoute(
        path: splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: authRoute, builder: (context, state) => const AthScreen()),
    ],
  );
}
