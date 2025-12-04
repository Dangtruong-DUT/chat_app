import 'dart:convert';
import 'package:chat_app/src/core/utils/constants/shared_references.constant.dart';
import 'package:chat_app/src/core/utils/id_generator.dart';
import 'package:chat_app/src/core/utils/json.type.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repositories.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final regiteredUsers = await getUserRegister();
      final user = regiteredUsers.firstWhereOrNull((u) => u.email == email);
      if (user == null) {
        throw Exception('User not found');
      }
      return Future.delayed(const Duration(seconds: 2), () => user);
    } catch (e) {
      Logger.error('AuthRepositoryImpl - login error: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = User(id: idGenerator(), name: name, email: email);
      final existingUsers = await getUserRegister();
      final isExiting = existingUsers.any((u) => u.email == email);
      if (isExiting) {
        throw Exception('Email already registered');
      }
      final updatedUsers = [...existingUsers, user];
      await saveUserRegister(updatedUsers);
      return Future.delayed(const Duration(seconds: 2), () => user);
    } catch (e) {
      Logger.error('AuthRepositoryImpl - register error: ${e.toString()}');
      rethrow;
    }
  }

  Future<List<User>> getUserRegister() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final usersString = prefs.getString(SharedReferenceConfig.accountListKey);
      if (usersString == null) return [];
      final List<dynamic> usersJson = jsonDecode(usersString);
      final List<Json> jsonList = usersJson.map((e) => e as Json).toList();
      return User.fromJsonList(jsonList);
    } catch (e) {
      Logger.error(
        'AuthRepositoryImpl - Get User Register Error: ${e.toString()}',
      );
    }
    return [];
  }

  Future<void> saveUserRegister(List<User> users) async {
    try {
      final data = await SharedPreferences.getInstance();
      final usersJson = users.map((u) => u.toJson()).toList();
      await data.setString(
        SharedReferenceConfig.accountListKey,
        jsonEncode(usersJson),
      );
    } catch (e) {
      Logger.error(
        'AuthRepositoryImpl - Save User Register Error: ${e.toString()}',
      );
    }
  }
}
