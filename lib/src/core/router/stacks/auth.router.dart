import 'package:chat_app/src/features/auth/presentation/pages/auth/index.dart';
import 'package:chat_app/src/features/auth/presentation/pages/login/index.dart';
import 'package:chat_app/src/features/auth/presentation/pages/splash/index.dart';
import 'package:go_router/go_router.dart';
import '../routes.config.dart';

class AuthRouter {
  AuthRouter._();
  static List<GoRoute> routes = [
    GoRoute(
      path: AppRoutesConfig.splash,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(path: AppRoutesConfig.auth, builder: (_, __) => const AuthScreen()),
    GoRoute(
      path: AppRoutesConfig.login,
      builder: (_, __) => const LoginScreen(),
    ),
  ];
}
