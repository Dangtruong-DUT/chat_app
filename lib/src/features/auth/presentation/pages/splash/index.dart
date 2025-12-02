import 'package:chat_app/src/core/router/router.config.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_bloc.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _handleAuthState(context, context.read<AuthBloc>().state);
    return _buildBlocListener(
      Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgPicture.asset('assets/svg/app_logo.svg', width: 60)],
          ),
        ),
      ),
    );
  }

  Widget _buildBlocListener(Widget child) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        _handleAuthState(context, state);
      },
      child: child,
    );
  }

  void _handleAuthState(BuildContext context, AuthState state) {
    if (state is Authenticated) {
      GoRouter.of(context).go(TRouterConfig.chatsRoute);
    } else if (state is Unauthenticated) {
      GoRouter.of(context).go(TRouterConfig.authRoute);
    } else {
      Logger.debug('SplashScreen - Auth State: ${state.runtimeType}');
    }
  }
}
