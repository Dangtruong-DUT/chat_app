import 'package:chat_app/src/features/user/data/models/user.model.dart';

abstract class UserLocalDataSource {
  Future<List<UserModel>> getAllUsers();
}
