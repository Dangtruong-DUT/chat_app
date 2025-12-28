import 'dart:convert';

import 'package:chat_app/src/core/utils/constants/shared_references.constant.dart';
import 'package:chat_app/src/features/search/data/datasources/search_local_data_source.dart';
import 'package:chat_app/src/shared/data/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final SharedPreferences store;

  const SearchLocalDataSourceImpl({required this.store});

  @override
  Future<List<UserModel>> getRegisteredUsers() async {
    final usersString = store.getString(SharedReferenceConfig.accountListKey);
    if (usersString == null) return [];
    final List<dynamic> usersJson = jsonDecode(usersString);
    return UserModel.fromJsonList(usersJson.cast<Map<String, dynamic>>());
  }
}
