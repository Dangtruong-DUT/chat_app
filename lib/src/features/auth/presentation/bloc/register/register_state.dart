import 'package:chat_app/src/core/utils/error/base/error.exception.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';

sealed class RegisterState {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  final User user;
  const RegisterSuccess(this.user);
}

class RegisterFailure extends RegisterState {
  final ErrorException error;

  const RegisterFailure(this.error);
}
