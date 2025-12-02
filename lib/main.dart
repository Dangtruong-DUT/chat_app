import 'package:chat_app/src/core/router/router.config.dart';
import 'package:chat_app/src/features/auth/domain/usecases/login.usecase.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/login/login-bloc.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/src/core/theme/app_theme.dart';
import 'package:chat_app/src/app_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() async {
  getIt.debugEventsEnabled = true;
  await configureAppDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => (LoginBloc(loginUseCase: getIt<LoginUseCase>())),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Chat App',
      theme: TAppTheme.lightTheme,
      routerConfig: TRouterConfig.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
