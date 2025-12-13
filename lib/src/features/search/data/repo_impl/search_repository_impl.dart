import 'dart:convert';
import 'package:chat_app/src/core/utils/constants/shared_references.constant.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/type.dart';
import 'package:chat_app/src/features/search/domain/repositories/search_repository.usecase.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepositoryImpl implements SearchRepository {
  const SearchRepositoryImpl();

  @override
  Future<List<User>> searchUsers({required String query}) async {
    try {
      final store = await SharedPreferences.getInstance();
      final usersString = store.getString(SharedReferenceConfig.accountListKey);
      if (usersString == null) return [];
      final List<dynamic> usersJson = jsonDecode(usersString);
      final List<Json> jsonList = usersJson.map((e) => e as Json).toList();
      final List<User> allUsers = User.fromJsonList(jsonList);
      final lowerCaseQuery = query.toLowerCase();
      final filteredUsers = allUsers.where((user) {
        final nameMatch = user.name.toLowerCase().contains(lowerCaseQuery);
        final emailMatch = user.email.toLowerCase().contains(lowerCaseQuery);
        return nameMatch || emailMatch;
      }).toList();
      return Future.delayed(const Duration(seconds: 1), () => filteredUsers);
    } catch (e) {
      Logger.error('SearchRepositoryImpl.searchUsers: $e');
      rethrow;
    }
  }
}
