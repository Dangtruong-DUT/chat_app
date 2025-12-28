import 'package:chat_app/src/app.dart';
import 'package:chat_app/src/app_injection.dart';
import 'package:chat_app/src/core/utils/formatting/timeFormatter/time_ago.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initCustomTimeMessages();

  GetIt.instance.debugEventsEnabled = true;
  await AppInjectionModule().register();
  await GetIt.instance.allReady();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppAuthBloc>(create: (_) => GetIt.instance<AppAuthBloc>()),
      ],
      child: const AppBootstrap(),
    ),
  );
}
