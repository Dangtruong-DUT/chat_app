import 'package:chat_app/src/shared/domain/entities/user.entity.dart';

abstract class SearchRepository {
  Future<List<User>> searchUsers({required String query});
}
