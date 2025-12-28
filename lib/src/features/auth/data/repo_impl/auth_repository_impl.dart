import 'package:chat_app/src/core/utils/id_generator.dart';
import 'package:chat_app/src/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/features/user/data/models/user.model.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';
import 'package:collection/collection.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<User> login({required String email, required String password}) async {
    final users = await localDataSource.getRegisteredUsers();
    final user = users.firstWhereOrNull((u) => u.email == email);

    if (user == null) {
      throw Exception('User not found!');
    }

    return Future.delayed(const Duration(seconds: 2), () => user.toEntity());
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final users = await localDataSource.getRegisteredUsers();

    if (users.any((u) => u.email == email)) {
      throw Exception('Email already registered');
    }

    final user = User(id: IDGenerator.generator(), name: name, email: email);
    final userModel = UserModel.fromEntity(user);

    await localDataSource.saveRegisteredUsers([...users, userModel]);
    return Future.delayed(const Duration(seconds: 2), () => user);
  }

  @override
  Future<User?> getLoginData() {
    return localDataSource.getLoginUser().then((value) => value?.toEntity());
  }

  @override
  Future<void> saveLoginData(User user) {
    return localDataSource.saveLoginUser(UserModel.fromEntity(user));
  }

  @override
  Future<void> clearLoginData() {
    return localDataSource.clearLoginUser();
  }

  @override
  Future<List<User>> getLoginHistory() {
    return localDataSource.getLoginHistory().then(UserModel.toEntityList);
  }

  @override
  Future<void> saveLoginHistory(List<User> users) {
    final userModels = UserModel.fromEntityList(users);
    return localDataSource.saveLoginHistory(userModels);
  }
}
