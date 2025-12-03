import 'package:chat_app/src/core/router/routes.config.dart';
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          GoRouter.of(context).go(AppRoutesConfig.chats);
        } else if (state is Unauthenticated) {
          GoRouter.of(context).go(AppRoutesConfig.login);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SvgPicture.asset('assets/svg/app_logo.svg', width: 60)],
          ),
        ),
      ),
    );
  }
}
