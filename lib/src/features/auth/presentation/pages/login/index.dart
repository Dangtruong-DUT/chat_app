import 'package:chat_app/main.dart';
import 'package:chat_app/src/features/auth/domain/usecases/login.usecase.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/login/login-bloc.dart';
import 'package:chat_app/src/features/auth/presentation/pages/login/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_bloc.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_state.dart';
import 'package:chat_app/src/core/router/routes.config.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => (LoginBloc(loginUseCase: getIt<LoginUseCase>())),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go(AppRoutesConfig.chats);
          }
        },
        child: const _LoginContent(),
      ),
    );
  }
}

class _LoginContent extends StatelessWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            Text(
              'Login',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Expanded(child: LoginForm()),
          ],
        ),
      ),
    );
  }
}
