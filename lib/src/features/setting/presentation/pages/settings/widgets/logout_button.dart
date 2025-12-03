import 'package:chat_app/src/shared/presentation/bloc/auth/auth_bloc.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:chat_app/src/core/router/routes.config.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          side: BorderSide(color: colorScheme.primary, width: 1.5),
          foregroundColor: colorScheme.primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
        icon: Icon(Icons.logout, color: colorScheme.primary),
        label: const Text('Logout'),
        onPressed: () => _handleLogout(context),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(AuthLogoutRequested());
    context.go(AppRoutesConfig.auth);
  }
}
