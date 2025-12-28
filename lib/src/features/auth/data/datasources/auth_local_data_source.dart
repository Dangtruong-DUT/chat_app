import 'package:chat_app/src/shared/data/models/user.model.dart';

abstract class AuthLocalDataSource {
  Future<List<UserModel>> getRegisteredUsers();
  Future<void> saveRegisteredUsers(List<UserModel> users);

  Future<UserModel?> getLoginUser();
  Future<void> saveLoginUser(UserModel user);
  Future<void> clearLoginUser();

  Future<List<UserModel>> getLoginHistory();
  Future<void> saveLoginHistory(List<UserModel> users);
}
