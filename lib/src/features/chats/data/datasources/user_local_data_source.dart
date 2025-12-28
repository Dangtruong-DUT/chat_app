import 'package:chat_app/src/shared/data/models/user.model.dart';

abstract class UserLocalDataSource {
  Future<List<UserModel>> getAllUsers();
}
