import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

abstract class UserRepository {
  Future<User?> getUserById(String id);
  Future<User?> getUserByEmail(String email);
  Future<List<User>> getAllUsers();
  Future<User> saveUser(User user);
  Future<void> deleteUser(String id);
  Future<void> updateUser(User user);
  Future<void> clearAllUsers();
  Future<bool> isUserExists(String id);
  Future<User?> getCurrentUser();
}
