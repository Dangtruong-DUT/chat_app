import 'package:chat_app/src/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/pages/register/widgets/register_form.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/register/register_state.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_state.dart';
import 'package:chat_app/src/core/router/routes.config.dart';

class RegisterScreen extends StatelessWidget {
  final String? prefilledEmail;
  const RegisterScreen({super.key, this.prefilledEmail});

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
                  'Register',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(child: RegisterForm(prefilledEmail: prefilledEmail)),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => _onLoginTap(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text('Already have an account? Login'),
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
      create: (_) => GetIt.instance<RegisterBloc>(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<RegisterBloc, RegisterState>(
            listenWhen: (_, current) =>
                current is RegisterFailure || current is RegisterSuccess,
            listener: (context, state) {
              if (state is RegisterFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (state is RegisterSuccess) {
                context.read<AppAuthBloc>().add(
                  AppAuthLoginRequested(user: state.user),
                );
              }
            },
          ),
          BlocListener<AppAuthBloc, AppAuthState>(
            listener: (context, state) {
              if (state is AppAuthenticated) {
                context.go(AppRoutesConfig.chats);
              }
            },
          ),
        ],
        child: child,
      ),
    );
  }

  void _onLoginTap(BuildContext context) {
    GoRouter.of(context).replace(AppRoutesConfig.login);
  }
}
