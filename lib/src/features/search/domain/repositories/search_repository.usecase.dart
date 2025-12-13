import 'package:chat_app/src/shared/domain/models/user.model.dart';

abstract class SearchRepository {
  Future<List<User>> searchUsers({required String query});
}
