import 'package:chat_app/src/features/chats/presentation/pages/chat_detail/index.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'routes.config.dart';
import 'stacks/auth.router.dart';
import 'tabs/home.router.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutesConfig.chats,
    routes: [
      ...AuthRouter.routes,
      HomeRouter.routes,
      GoRoute(
        path: AppRoutesConfig.chatDetail,
        builder: (_, state) => ChatDetailScreen(
          chatId: state.uri.queryParameters[ChatDetailRouteQueryKeys.chatId],
          userId: state.uri.queryParameters[ChatDetailRouteQueryKeys.userId],
        ),
      ),
    ],
    redirect: _redirectLogic,
  );

  static String? _redirectLogic(BuildContext context, GoRouterState state) {
    final currentAuthState = BlocProvider.of<AppAuthBloc>(
      context,
      listen: false,
    ).state;
    if (currentAuthState is AppAuthLoading) return AppRoutesConfig.splash;

    final isAuthenticated = currentAuthState is AppAuthenticated;
    final isProtectedPath = AppRoutesConfig.protected.any(
      (path) => state.fullPath!.startsWith(path),
    );
    if (!isAuthenticated && isProtectedPath) return AppRoutesConfig.auth;

    final isAuthPage = AppRoutesConfig.authPages.any(
      (path) => state.fullPath!.startsWith(path),
    );
    if (isAuthenticated && isAuthPage) return AppRoutesConfig.chats;

    return null;
  }
}
