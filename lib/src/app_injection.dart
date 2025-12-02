import 'package:chat_app/src/features/auth/auth_injection.dart';

Future<void> configureAppDependencies() async {
  await configureAuthDependencies();
}
