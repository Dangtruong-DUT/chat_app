import 'package:chat_app/src/features/auth/presentation/pages/splash/index.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_bloc.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'routes.config.dart';
import 'stacks/auth.router.dart';
import 'tabs/home.router.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesConfig.splash,
    routes: [
      GoRoute(
        path: AppRoutesConfig.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      ...AuthRouter.routes,
      HomeRouter.routes,
    ],
    redirect: _redirectLogic,
  );

  static String? _redirectLogic(BuildContext context, GoRouterState state) {
    final currentAuthState = BlocProvider.of<AuthBloc>(
      context,
      listen: false,
    ).state;
    if (currentAuthState is AuthLoading) return null;
    final isAuthenticated = currentAuthState is Authenticated;

    final isProtectedPath = AppRoutesConfig.protected.contains(state.fullPath);
    if (!isAuthenticated && isProtectedPath) return AppRoutesConfig.login;

    final isAuthPage = AppRoutesConfig.authPages.contains(state.fullPath);
    if (isAuthenticated && isAuthPage) return AppRoutesConfig.home;

    return null;
  }
}
