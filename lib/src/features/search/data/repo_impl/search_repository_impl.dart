import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/search/data/datasources/search_local_data_source.dart';
import 'package:chat_app/src/features/search/domain/repositories/search_repository.dart';
import 'package:chat_app/src/shared/data/models/user.model.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchLocalDataSource _localDataSource;

  const SearchRepositoryImpl({required SearchLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Future<List<User>> searchUsers({required String query}) async {
    try {
      final List<UserModel> allUsers = await _localDataSource
          .getRegisteredUsers();
      final lowerCaseQuery = query.toLowerCase();
      final filteredUsers = allUsers.where((user) {
        final nameMatch = user.name.toLowerCase().contains(lowerCaseQuery);
        final emailMatch = user.email.toLowerCase().contains(lowerCaseQuery);
        return nameMatch || emailMatch;
      }).toList();
      final results = UserModel.toEntityList(filteredUsers);
      return Future.delayed(const Duration(seconds: 1), () => results);
    } catch (e) {
      Logger.error('SearchRepositoryImpl.searchUsers: $e');
      rethrow;
    }
  }
}
