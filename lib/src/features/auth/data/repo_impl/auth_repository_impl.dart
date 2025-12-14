import 'dart:convert';
import 'package:chat_app/src/core/utils/constants/shared_references.constant.dart';
import 'package:chat_app/src/core/utils/exception/base/error.exception.dart';
import 'package:chat_app/src/core/utils/id_generator.dart';
import 'package:chat_app/src/core/utils/type.dart';
import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repositories.dart';
import 'package:chat_app/src/features/user/data/models/user.model.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User> login({required String email, required String password}) async {
    try {
      final registeredUsers = await getUserRegister();
      final user = registeredUsers.firstWhereOrNull((u) => u.email == email);
      if (user == null) {
        throw ErrorException(message: 'User not found!');
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
      final user = User(id: IDGenerator.generator(), name: name, email: email);
      final existingUsers = await getUserRegister();
      final isExiting = existingUsers.any((u) => u.email == email);
      if (isExiting) {
        throw ErrorException(message: 'Email already registered');
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
      final store = await SharedPreferences.getInstance();
      final usersString = store.getString(SharedReferenceConfig.accountListKey);
      if (usersString == null) return [];
      final List<dynamic> usersJson = jsonDecode(usersString);
      final List<Json> jsonList = usersJson.map((e) => e as Json).toList();
      return UserModel.fromJsonList(jsonList);
    } catch (e) {
      Logger.error(
        'AuthRepositoryImpl - Get User Register Error: ${e.toString()}',
      );
      rethrow;
    }
  }

  Future<void> saveUserRegister(List<User> users) async {
    try {
      final userModels = users.map((u) => UserModel.fromEntity(u)).toList();
      final store = await SharedPreferences.getInstance();
      final usersJson = userModels.map((u) => u.toJson()).toList();
      await store.setString(
        SharedReferenceConfig.accountListKey,
        jsonEncode(usersJson),
      );
    } catch (e) {
      Logger.error(
        'AuthRepositoryImpl - Save User Register Error: ${e.toString()}',
      );
      rethrow;
    }
  }

  @override
  Future<User?> getLoginData() async {
    try {
      final data = await SharedPreferences.getInstance();
      final String? userString = data.getString(
        SharedReferenceConfig.userDataKey,
      );
      if (userString == null) return null;

      final Json userJson = jsonDecode(userString);
      return UserModel.fromJson(userJson);
    } catch (e) {
      Logger.error(
        'AuthRepositoryImpl - Get Login Data Error: ${e.toString()}',
      );
    }

    return null;
  }

  @override
  Future<void> saveLoginData(User user) async {
    final UserModel userModel = UserModel.fromEntity(user);
    final data = await SharedPreferences.getInstance();
    final String userString = jsonEncode(userModel.toJson());
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
      final store = await SharedPreferences.getInstance();
      final usersString = store.getString(
        SharedReferenceConfig.loginHistoryKey,
      );
      if (usersString == null) return [];
      final List<dynamic> usersJson = jsonDecode(usersString);
      final List<Json> jsonList = usersJson.map((e) => e as Json).toList();
      return UserModel.fromJsonList(jsonList);
    } catch (e) {
      Logger.error(
        'AuthRepositoryImpl - Get Login History Error: ${e.toString()}',
      );
    }
    return [];
  }

  @override
  Future<void> saveLoginHistory(List<User> users) async {
    final userModels = users.map((u) => UserModel.fromEntity(u)).toList();
    final data = await SharedPreferences.getInstance();
    final String usersString = jsonEncode(
      userModels.map((user) => user.toJson()).toList(),
    );
    await data.setString(SharedReferenceConfig.loginHistoryKey, usersString);
  }
}
