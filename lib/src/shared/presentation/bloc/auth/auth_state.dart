import 'package:chat_app/src/shared/domain/models/user.model.dart';

sealed class AuthState {
  const AuthState();
}

class Authenticated extends AuthState {
  final User user;
  const Authenticated(this.user);
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}
