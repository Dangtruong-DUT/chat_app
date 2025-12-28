import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_history/auth_history_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_history/auth_history_event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_history/auth_history_state.dart';
import 'package:chat_app/src/features/auth/presentation/pages/auth_history/widgets/accountItem.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginHistoryList extends StatelessWidget {
  const LoginHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthHistoryBloc, AuthHistoryState>(
      builder: (context, state) {
        switch (state.status) {
          case AuthHistoryStatus.loading:
            return const _HistoryLoading();
          case AuthHistoryStatus.failure:
            return _HistoryError(
              message:
                  state.error?.message ?? 'Không thể tải lịch sử đăng nhập',
              onRetry: () => _onRetry(context),
            );
          case AuthHistoryStatus.success:
            if (state.history.isEmpty) {
              return const _HistoryEmpty();
            }
            return _HistoryWrap(
              users: state.history,
              onDelete: (id) => _onDeleteAccountTap(context, id),
              onTap: (user) => _onAccountTap(context, user),
            );
          case AuthHistoryStatus.initial:
            return const SizedBox.shrink();
        }
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

  void _onRetry(BuildContext context) {
    context.read<AuthHistoryBloc>().add(const AuthHistoryFetchRequested());
  }
}

class _HistoryWrap extends StatelessWidget {
  final List<User> users;
  final ValueChanged<String> onDelete;
  final ValueChanged<User> onTap;

  const _HistoryWrap({
    required this.users,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: users
          .map(
            (user) => AccountItem(
              user: user,
              onDelete: () => onDelete(user.id),
              onTap: () => onTap(user),
            ),
          )
          .toList(),
    );
  }
}

class _HistoryLoading extends StatelessWidget {
  const _HistoryLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _HistoryEmpty extends StatelessWidget {
  const _HistoryEmpty();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people_outline, size: 48, color: Colors.grey.shade500),
          const SizedBox(height: 12),
          Text('Chưa có tài khoản nào', style: textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(
            'Thêm tài khoản để thuận tiện đăng nhập lần sau.',
            textAlign: TextAlign.center,
            style: textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}

class _HistoryError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _HistoryError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red.shade400),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Thử lại'),
          ),
        ],
      ),
    );
  }
}
