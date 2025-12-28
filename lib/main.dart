import 'package:chat_app/src/app.dart';
import 'package:chat_app/src/app_injection.dart';
import 'package:chat_app/src/core/utils/formatting/timeFormatter/time_ago.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

final _getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initCustomTimeMessages();

  _getIt.debugEventsEnabled = true;
  await AppInjectionModule().register();
  await _getIt.allReady();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppAuthBloc>(create: (_) => _getIt<AppAuthBloc>()),
      ],
      child: const AppBootstrap(),
    ),
  );
}
