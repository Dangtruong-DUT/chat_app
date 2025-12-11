import 'package:chat_app/src/core/router/root.route.dart';
import 'package:chat_app/src/shared/domain/usecases/clear_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/get_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/save_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/get_login_history.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/add_login_history.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/delete_login_history.usecase.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_bloc.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/src/core/theme/app_theme.dart';
import 'package:chat_app/app_injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:chat_app/src/core/utils/formatting/timeFormatter/time_ago.dart';

final getIt = GetIt.instance;

void main() async {
  getIt.debugEventsEnabled = true;
  initCustomTimeMessages();
  await configureAppDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
            clearCurrentUserUseCase: getIt<ClearCurrentUserUseCase>(),
            saveCurrentUserUseCase: getIt<SaveCurrentUserUseCase>(),
            getLoginHistoryUseCase: getIt<GetLoginHistoryUseCase>(),
            addLoginHistoryUseCase: getIt<AddLoginHistoryUseCase>(),
            deleteLoginHistoryUseCase: getIt<DeleteLoginHistoryUseCase>(),
          )..add(AuthCheckRequested()),
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
