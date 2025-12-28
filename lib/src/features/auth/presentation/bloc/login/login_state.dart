import 'package:chat_app/src/core/utils/error/base/error.exception.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

sealed class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final User user;
  const LoginSuccess(this.user);
}

class LoginFailure extends LoginState {
  final ErrorException error;

  const LoginFailure(this.error);
}
