import 'package:chat_app/app_injection.dart';
import 'package:chat_app/src/core/router/root.route.dart';
import 'package:chat_app/src/core/theme/app_theme.dart';
import 'package:chat_app/src/core/utils/formatting/timeFormatter/time_ago.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_bloc.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() async {
  getIt.debugEventsEnabled = true;
  initCustomTimeMessages();
  await AppInjectionModule().register();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>()..add(AuthCheckRequested()),
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
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
