import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_event.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';
import 'package:chat_app/src/shared/presentation/widgets/custom_avatar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfo extends StatelessWidget {
  final User user;
  const AccountInfo({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: CustomCircleAvatar(imageUrl: user.avatar),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                user.email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),

        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            side: BorderSide(color: primaryColor, width: 1.5),
            foregroundColor: primaryColor,
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
          icon: Icon(Icons.logout, color: primaryColor, size: 16),
          label: Text(tr('common.logout')),
          onPressed: () => _handleLogout(context),
        ),
      ],
    );
  }

  void _handleLogout(BuildContext context) {
    BlocProvider.of<AppAuthBloc>(context).add(AppAuthLogoutRequested());
    context.go(AppRoutesConfig.auth);
  }
}
