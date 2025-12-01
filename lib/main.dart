import 'package:chat_app/src/core/router/router.config.dart';
import 'package:chat_app/src/core/styles/app-theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
