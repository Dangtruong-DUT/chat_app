import 'package:chat_app/src/shared/domain/models/user.model.dart';

sealed class AuthEvent {
  const AuthEvent();
}

class AuthCheckRequested extends AuthEvent {}

class AuthLogoutRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final User user;
  AuthLoginRequested({required this.user});
}

class AuthDeleteLoginHistoryRequested extends AuthEvent {
  final String id;
  AuthDeleteLoginHistoryRequested({required this.id});
}
