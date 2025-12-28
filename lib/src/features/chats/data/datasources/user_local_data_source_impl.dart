import 'dart:convert';

import 'package:chat_app/src/core/utils/constants/shared_references.constant.dart';
import 'package:chat_app/src/features/chats/data/datasources/user_local_data_source.dart';
import 'package:chat_app/src/shared/data/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences store;

  UserLocalDataSourceImpl({required this.store});

  @override
  Future<List<UserModel>> getAllUsers() async {
    final raw = store.getString(SharedReferenceConfig.accountListKey);
    if (raw == null) return [];

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
