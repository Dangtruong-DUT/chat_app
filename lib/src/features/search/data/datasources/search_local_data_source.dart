import 'package:chat_app/src/features/user/data/models/user.model.dart';

abstract class SearchLocalDataSource {
  Future<List<UserModel>> getRegisteredUsers();
}
