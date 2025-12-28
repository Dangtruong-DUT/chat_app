import 'package:chat_app/src/core/router/root.route.dart';
import 'package:chat_app/src/core/theme/app_theme.dart';
import 'package:chat_app/src/core/theme/theme_mode.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_bloc.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_state.dart';
import 'package:chat_app/src/features/setting/presentation/bloc/theme/theme_bloc.dart';
import 'package:chat_app/src/features/setting/presentation/bloc/theme/theme_event.dart';
import 'package:chat_app/src/features/setting/presentation/bloc/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class AppBootstrap extends StatefulWidget {
  const AppBootstrap({super.key});

  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  @override
  void initState() {
    super.initState();
    context.read<AppAuthBloc>().add(AppAuthCheckRequested());
    context.read<ThemeBloc>().add(const ThemeModeRequested());
  }

  @override
  Widget build(BuildContext context) {
    return _buildBloc(child: const MyApp());
  }

  Widget _buildBloc({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AppAuthBloc, AppAuthState>(
          listenWhen: (previous, current) =>
              previous.error != current.error && current.error != null,
          listener: (context, state) {
            final error = state.error;
            if (error == null) return;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(error.message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
          },
        ),
        BlocListener<ThemeBloc, ThemeState>(
          listenWhen: (previous, current) =>
              previous.error != current.error && current.error != null,
          listener: (context, state) {
            final error = state.error;
            if (error == null) return;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(error.message),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
          },
        ),
      ],
      child: child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final themeMode = state.mode.materialMode;
        return MaterialApp.router(
          title: tr('app.title'),
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          themeMode: themeMode,
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        );
      },
    );
  }
}
