import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_history/auth_history_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_history/auth_history_event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_history/auth_history_state.dart';
import 'package:chat_app/src/features/auth/presentation/pages/auth_history/widgets/accountItem.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginHistoryList extends StatelessWidget {
  const LoginHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthHistoryBloc, AuthHistoryState>(
      builder: (context, state) {
        final users = state.history;

        return Wrap(
          spacing: 8,
          runSpacing: 4,
          children: users
              .map(
                (user) => AccountItem(
                  user: user,
                  onDelete: () => _onDeleteAccountTap(context, user.id),
                  onTap: () => _onAccountTap(context, user),
                ),
              )
              .toList(),
        );
      },
    );
  }

  void _onDeleteAccountTap(BuildContext context, String userId) {
    context.read<AuthHistoryBloc>().add(
      AuthHistoryDeleteItemRequested(id: userId),
    );
  }

  void _onAccountTap(BuildContext context, User user) {
    GoRouter.of(context).push(
      Uri(
        path: AppRoutesConfig.login,
        queryParameters: {LoginRouteQueryKeys.email: user.email},
      ).toString(),
    );
  }
}
