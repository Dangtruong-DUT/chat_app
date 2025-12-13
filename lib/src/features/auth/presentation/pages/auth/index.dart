import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/login/login-bloc.dart';
import 'package:chat_app/src/features/auth/presentation/pages/auth/widgets/login_history_list.dart';
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
                            const LoginHistoryList(),

                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () => _onAddAccountTap(context),
                                  child: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Icon(Icons.add, size: 30),
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
      create: (_) => GetIt.instance<LoginBloc>(),
      child: child,
    );
  }

  void _onRegisterTap(BuildContext context) {
    GoRouter.of(context).push(AppRoutesConfig.register);
  }

  void _onAddAccountTap(BuildContext context) {
    GoRouter.of(context).push(AppRoutesConfig.login);
  }
}
