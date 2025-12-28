import 'package:chat_app/src/app.dart';
import 'package:chat_app/src/app_injection.dart';
import 'package:chat_app/src/core/utils/formatting/timeFormatter/time_ago.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:chat_app/src/features/setting/presentation/bloc/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:chat_app/src/core/i18n/app_locale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  initCustomTimeMessages();

  GetIt.instance.debugEventsEnabled = true;
  await AppInjectionModule().register();
  await GetIt.instance.allReady();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale(AppLocale.en), Locale(AppLocale.vi)],
      path: 'assets/translations',
      fallbackLocale: const Locale(AppLocale.en),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppAuthBloc>(
            create: (_) => GetIt.instance<AppAuthBloc>(),
          ),
          BlocProvider<ThemeBloc>(create: (_) => GetIt.instance<ThemeBloc>()),
        ],
        child: const AppBootstrap(),
      ),
    ),
  );
}
