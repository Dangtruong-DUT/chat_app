import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/auth/presentation/pages/auth/widgets/accountItem.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_bloc.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_event.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginHistoryList extends StatelessWidget {
  const LoginHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is Unauthenticated) {
          return Wrap(
            spacing: 8,
            runSpacing: 4,
            children: state.loginHistory
                .map(
                  (user) => AccountItem(
                    user: user,
                    onDelete: () => _onDeleteAccountTap(context, user.id),
                    onTap: () => _onAccountTap(context, user),
                  ),
                )
                .toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _onDeleteAccountTap(BuildContext context, String userId) {
    context.read<AuthBloc>().add(AuthDeleteLoginHistoryRequested(id: userId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Deleted account successfully')),
    );
  }

  void _onAccountTap(BuildContext context, User user) {
    GoRouter.of(
      context,
    ).push('${AppRoutesConfig.login}?email=${Uri.encodeComponent(user.email)}');
  }
}
