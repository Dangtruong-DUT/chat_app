import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

abstract class AuthRepository {
  Future<User> login({required String email, required String password});
  Future<User> register({
    required String email,
    required String password,
    required String name,
  });

  Future<User?> getLoginData();
  Future<void> saveLoginData(User user);
  Future<void> clearLoginData();

  Future<List<User>> getLoginHistory();
  Future<void> saveLoginHistory(List<User> users);
}
