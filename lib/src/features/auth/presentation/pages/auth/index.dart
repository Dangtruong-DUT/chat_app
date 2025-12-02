import 'package:chat_app/main.dart';
import 'package:chat_app/src/core/router/routes.config.dart';
import 'package:chat_app/src/features/auth/domain/usecases/login.usecase.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/login/login-bloc.dart';
import 'package:chat_app/src/features/auth/presentation/pages/auth/widgets/_mock/index.dart';
import 'package:chat_app/src/features/auth/presentation/pages/auth/widgets/accountItem.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => (LoginBloc(loginUseCase: getIt<LoginUseCase>())),
      child: _AuthScreenContent(),
    );
  }
}

class _AuthScreenContent extends StatelessWidget {
  const _AuthScreenContent();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 8.0,
            runSpacing: 4.0,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.start,
            children: [
              ...usersMockData
                  .sublist(0, 3)
                  .map((user) => AccountItem(user: user))
                  .toList(),

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
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
    );
  }

  void _onAddAccountTap(BuildContext context) {
    GoRouter.of(context).push(AppRoutesConfig.login);
  }
}
