import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/account-info.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AppAuthBloc>().state as AppAuthenticated).user;
    return BlocListener<AppAuthBloc, AppAuthState>(
      listener: (context, state) {
        if (state is AppUnauthenticated) {
          GoRouter.of(context).go(AppRoutesConfig.auth);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings", textAlign: TextAlign.center),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AccountInfo(user: user),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
