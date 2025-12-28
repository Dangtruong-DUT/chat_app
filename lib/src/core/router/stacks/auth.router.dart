import 'package:chat_app/src/features/auth/presentation/pages/auth_history/index.dart';
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
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutesConfig.auth,
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: AppRoutesConfig.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutesConfig.login,
      builder: (context, state) {
        final email = state.uri.queryParameters[LoginRouteQueryKeys.email];
        return LoginScreen(prefilledEmail: email);
      },
    ),
  ];
}
