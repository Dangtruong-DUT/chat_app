import 'package:chat_app/src/features/auth/domain/dtos/login.dto.dart';
import 'package:chat_app/src/features/auth/domain/dtos/register.dto.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';

abstract class AuthRepository {
  Future<User> login(LoginBodyDto body);
  Future<User> register(RegisterBodyDto body);
}
