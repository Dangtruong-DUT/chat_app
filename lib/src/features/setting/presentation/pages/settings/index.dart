import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'widgets/account-info.dart';
import 'widgets/language_selector.dart';
import 'widgets/theme_mode_selector.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppAuthBloc, AppAuthState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == AppAuthStatus.unauthenticated,
      listener: (context, state) {
        GoRouter.of(context).go(AppRoutesConfig.auth);
      },
      child: BlocBuilder<AppAuthBloc, AppAuthState>(
        builder: (context, state) {
          final user = state.user;
          if (user == null) {
            return const SizedBox.shrink();
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(tr('settings.title'), textAlign: TextAlign.center),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AccountInfo(user: user),
                  const SizedBox(height: 24),
                  const ThemeModeSelector(),
                  const LanguageSelector(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
