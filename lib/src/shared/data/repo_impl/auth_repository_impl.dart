import 'dart:convert';

import 'package:chat_app/src/core/utils/constants/shared_references.constant.dart';
import 'package:chat_app/src/core/utils/json.type.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:chat_app/src/shared/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User?> getLoginData() async {
    final data = await SharedPreferences.getInstance();
    final String? userString = data.getString(userDataKey);
    if (userString != null) {
      final Json userJson = jsonDecode(userString);
      return User.fromJson(userJson);
    }
    return null;
  }

  @override
  Future<void> saveLoginData(User user) async {
    final data = await SharedPreferences.getInstance();
    final String userString = jsonEncode(user.toJson());
    await data.setString(userDataKey, userString);
  }

  @override
  Future<void> clearLoginData() async {
    final data = await SharedPreferences.getInstance();
    await data.remove(userDataKey);
  }
}
