import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:chat_app/src/shared/domain/repositories/auth_repository.dart';

class AddLoginHistoryUseCase implements BaseUseCase<List<User>, User> {
  final AuthRepository repository;
  final int maxItems;

  AddLoginHistoryUseCase({required this.repository, this.maxItems = 6});

  @override
  Future<List<User>> call({required User params}) async {
    try {
      final current = await repository.getLoginHistory();
      final filtered = current.where((u) => u.email != params.email).toList();
      filtered.insert(0, params);
      final trimmed = filtered.take(maxItems).toList();
      await repository.saveLoginHistory(trimmed);
      return trimmed;
    } catch (e) {
      Logger.error('AddLoginHistoryUseCase - error: ${e.toString()}');
      return [];
    }
  }
}
