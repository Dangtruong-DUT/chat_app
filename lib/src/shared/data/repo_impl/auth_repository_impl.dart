import 'dart:convert';
import 'package:chat_app/src/core/utils/constants/shared_references.constant.dart';
import 'package:chat_app/src/core/utils/type.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:chat_app/src/shared/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User?> getLoginData() async {
    try {
      final data = await SharedPreferences.getInstance();
      final String? userString = data.getString(
        SharedReferenceConfig.userDataKey,
      );
      if (userString == null) return null;

      final Json userJson = jsonDecode(userString);
      return User.fromJson(userJson);
    } catch (e) {
      Logger.error(
        'AuthRepositoryImpl - Get Login Data Error: ${e.toString()}',
      );
    }

    return null;
  }

  @override
  Future<void> saveLoginData(User user) async {
    final data = await SharedPreferences.getInstance();
    final String userString = jsonEncode(user.toJson());
    await data.setString(SharedReferenceConfig.userDataKey, userString);
  }

  @override
  Future<void> clearLoginData() async {
    final data = await SharedPreferences.getInstance();
    await data.remove(SharedReferenceConfig.userDataKey);
  }

  @override
  Future<List<User>> getLoginHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersString = prefs.getString(
        SharedReferenceConfig.loginHistoryKey,
      );
      if (usersString == null) return [];
      final List<dynamic> usersJson = jsonDecode(usersString);
      final List<Json> jsonList = usersJson.map((e) => e as Json).toList();
      return User.fromJsonList(jsonList);
    } catch (e) {
      Logger.error(
        'AuthRepositoryImpl - Get Login History Error: ${e.toString()}',
      );
    }
    return [];
  }

  @override
  Future<void> saveLoginHistory(List<User> users) async {
    final data = await SharedPreferences.getInstance();
    final String usersString = jsonEncode(
      users.map((user) => user.toJson()).toList(),
    );
    await data.setString(SharedReferenceConfig.loginHistoryKey, usersString);
  }
}
