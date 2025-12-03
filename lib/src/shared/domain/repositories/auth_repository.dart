import 'package:chat_app/src/shared/domain/models/user.model.dart';

abstract class AuthRepository {
  Future<User?> getLoginData();
  Future<void> saveLoginData(User user);
  Future<void> clearLoginData();

  Future<List<User>> getLoginHistory();
  Future<void> saveLoginHistory(List<User> users);
}
