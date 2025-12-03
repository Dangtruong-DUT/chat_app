import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/home/presentation/pages/settings/widgets/logout_button.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_bloc.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/account-info.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthBloc>().state as Authenticated).user;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          GoRouter.of(context).go(AppRoutesConfig.auth);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings", textAlign: TextAlign.center),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AccountInfo(user: user),
            const SizedBox(height: 24),
            LogoutButton(),
          ],
        ),
      ),
    );
  }
}
