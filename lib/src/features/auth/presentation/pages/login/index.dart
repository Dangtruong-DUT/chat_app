import 'package:chat_app/main.dart';
import 'package:chat_app/src/features/auth/domain/usecases/login.usecase.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/login/login-bloc.dart';
import 'package:chat_app/src/features/auth/presentation/pages/login/widgets/login_form.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/login/login-state.dart';
import 'package:go_router/go_router.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_bloc.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_state.dart';
import 'package:chat_app/src/core/router/routes.config.dart';

class LoginScreen extends StatelessWidget {
  final String? prefilledEmail;
  const LoginScreen({super.key, this.prefilledEmail});

  @override
  Widget build(BuildContext context) {
    return _buildBlocProvider(
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(child: LoginForm(prefilledEmail: prefilledEmail)),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => _onRegisterTap(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlocProvider({required Widget child}) {
    return BlocProvider(
      create: (context) => (LoginBloc(loginUseCase: getIt<LoginUseCase>())),
      child: MultiBlocListener(
        listeners: [
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error.message)));
              }

              if (state is LoginSuccess) {
                context.read<AuthBloc>().add(
                  AuthLoginRequested(user: state.user),
                );
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                context.go(AppRoutesConfig.chats);
              }
            },
          ),
        ],
        child: child,
      ),
    );
  }

  void _onRegisterTap(BuildContext context) {
    GoRouter.of(context).replace(AppRoutesConfig.register);
  }
}
