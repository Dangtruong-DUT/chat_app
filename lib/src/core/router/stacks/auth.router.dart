import 'package:chat_app/src/features/auth/presentation/pages/auth/index.dart';
import 'package:chat_app/src/features/auth/presentation/pages/login/index.dart';
import 'package:chat_app/src/features/auth/presentation/pages/register/index.dart';
import 'package:chat_app/src/features/auth/presentation/pages/splash/index.dart';
import 'package:go_router/go_router.dart';
import '../routes.config.dart';

class AuthRouter {
  AuthRouter._();
  static List<GoRoute> routes = [
    GoRoute(
      path: AppRoutesConfig.splash,
      builder: (_, _) => const SplashScreen(),
    ),
    GoRoute(path: AppRoutesConfig.auth, builder: (_, __) => const AuthScreen()),
    GoRoute(
      path: AppRoutesConfig.register,
      builder: (_, _) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutesConfig.login,
      builder: (_, state) {
        final email = state.uri.queryParameters['email'];
        return LoginScreen(prefilledEmail: email);
      },
    ),
  ];
}
