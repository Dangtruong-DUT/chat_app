import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_history/auth_history_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_history/auth_history_event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_history/auth_history_state.dart';
import 'package:chat_app/src/features/auth/presentation/pages/auth_history/widgets/login_history_list.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBlocProvider(
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Center(
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 8.0,
                          runSpacing: 4.0,
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          children: [
                            BlocBuilder<AuthHistoryBloc, AuthHistoryState>(
                              buildWhen: (previous, current) =>
                                  previous.status != current.status ||
                                  previous.history != current.history,
                              builder: (context, state) {
                                final isLoading =
                                    state.status == AuthHistoryStatus.loading &&
                                    state.history.isEmpty;
                                if (isLoading) {
                                  return const _LoginHistoryLoadingIndicator();
                                }
                                return const LoginHistoryList();
                              },
                            ),

                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () => _onAddAccountTap(context),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surfaceVariant,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 30,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Add Account',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: TextButton(
                    onPressed: () => _onRegisterTap(context),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Text('Create a new account'),
                  ),
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
      create: (_) =>
          GetIt.instance<AuthHistoryBloc>()
            ..add(const AuthHistoryFetchRequested()),
      child: BlocListener<AuthHistoryBloc, AuthHistoryState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == AuthHistoryStatus.failure,
        listener: (context, state) {
          final message =
              state.error?.message ?? 'Đã xảy ra lỗi không xác định';
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
        },
        child: child,
      ),
    );
  }

  void _onRegisterTap(BuildContext context) {
    GoRouter.of(context).push(AppRoutesConfig.register);
  }

  void _onAddAccountTap(BuildContext context) {
    GoRouter.of(context).push(AppRoutesConfig.login);
  }
}

class _LoginHistoryLoadingIndicator extends StatelessWidget {
  const _LoginHistoryLoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(width: 36, height: 36, child: CircularProgressIndicator()),
          SizedBox(height: 12),
          Text('Đang tải...'),
        ],
      ),
    );
  }
}
