import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

abstract class SearchRepository {
  Future<List<User>> searchUsers({required String query});
}
