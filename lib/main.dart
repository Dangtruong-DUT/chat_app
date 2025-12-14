import 'package:chat_app/app_injection.dart';
import 'package:chat_app/src/core/router/root.route.dart';
import 'package:chat_app/src/core/theme/app_theme.dart';
import 'package:chat_app/src/core/utils/formatting/timeFormatter/time_ago.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  GetIt.instance.debugEventsEnabled = true;
  initCustomTimeMessages();
  await AppInjectionModule().register();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppAuthBloc>(
          create: (_) =>
              GetIt.instance<AppAuthBloc>()..add(AppAuthCheckRequested()),
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
