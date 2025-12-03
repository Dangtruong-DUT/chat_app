import 'package:chat_app/src/core/utils/id_generator.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/auth/domain/dtos/login.dto.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repositories.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User> login(LoginBodyDto body) {
    Logger.debug('AuthRepositoryImpl - login called with email: ${body.email}');
    return Future.delayed(const Duration(seconds: 2), () {
      final userId = idGenerator();
      return User(id: userId, name: 'John Doe', email: body.email);
    });
  }
}
