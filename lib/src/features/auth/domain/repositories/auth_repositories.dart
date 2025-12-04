import 'package:chat_app/src/shared/domain/models/user.model.dart';

abstract class AuthRepository {
  Future<User> login({required String email, required String password});
  Future<User> register({
    required String email,
    required String password,
    required String name,
  });
}
