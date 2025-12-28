import 'dart:convert';

import 'package:chat_app/src/core/utils/constants/shared_references.constant.dart';
import 'package:chat_app/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:chat_app/src/features/user/data/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences store;

  AuthLocalDataSourceImpl({required this.store});

  @override
  Future<List<UserModel>> getRegisteredUsers() async {
    final usersString = store.getString(SharedReferenceConfig.accountListKey);
    if (usersString == null) return [];
    final List<dynamic> usersJson = jsonDecode(usersString);
    return UserModel.fromJsonList(usersJson.cast<Map<String, dynamic>>());
  }

  @override
  Future<void> saveRegisteredUsers(List<UserModel> users) async {
    await store.setString(
      SharedReferenceConfig.accountListKey,
      jsonEncode(users.map((e) => e.toJson()).toList()),
    );
  }

  @override
  Future<UserModel?> getLoginUser() async {
    final userString = store.getString(SharedReferenceConfig.userDataKey);
    if (userString == null) return null;
    return UserModel.fromJson(jsonDecode(userString));
  }

  @override
  Future<void> saveLoginUser(UserModel user) async {
    await store.setString(
      SharedReferenceConfig.userDataKey,
      jsonEncode(user.toJson()),
    );
  }

  @override
  Future<void> clearLoginUser() async {
    await store.remove(SharedReferenceConfig.userDataKey);
  }

  @override
  Future<List<UserModel>> getLoginHistory() async {
    final usersString = store.getString(SharedReferenceConfig.loginHistoryKey);
    if (usersString == null) return [];
    final List<dynamic> usersJson = jsonDecode(usersString);
    return UserModel.fromJsonList(usersJson.cast<Map<String, dynamic>>());
  }

  @override
  Future<void> saveLoginHistory(List<UserModel> users) async {
    await store.setString(
      SharedReferenceConfig.loginHistoryKey,
      jsonEncode(users.map((e) => e.toJson()).toList()),
    );
  }
}
