import 'package:chat_app/src/features/auth/auth_injection.dart';
import 'package:chat_app/src/features/chats/chats_injection.dart';
import 'package:chat_app/src/shared/shared_injection.dart';

Future<void> configureAppDependencies() async {
  await Future.wait([
    configureSharedDependencies(),
    configureAuthFutureDependencies(),
    configureChatsFutureDependencies(),
  ]);
}
