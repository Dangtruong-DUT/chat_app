import 'package:chat_app/src/shared/data/models/user.model.dart';

abstract class SearchLocalDataSource {
  Future<List<UserModel>> getRegisteredUsers();
}
