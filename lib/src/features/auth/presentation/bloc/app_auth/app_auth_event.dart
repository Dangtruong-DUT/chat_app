import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

sealed class AppAuthEvent {
  const AppAuthEvent();
}

class AppAuthCheckRequested extends AppAuthEvent {}

class AppAuthLogoutRequested extends AppAuthEvent {}

class AppAuthLoginRequested extends AppAuthEvent {
  final User user;
  AppAuthLoginRequested({required this.user});
}
