import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';

class AddLoginHistoryUseCase implements BaseUseCase<List<User>, User> {
  final AuthRepository _repository;
  final int maxItems;

  AddLoginHistoryUseCase({
    required AuthRepository repository,
    this.maxItems = 6,
  }) : _repository = repository;

  @override
  Future<List<User>> call({required User params}) async {
    try {
      final current = await _repository.getLoginHistory();
      final filtered = current.where((u) => u.email != params.email).toList();
      filtered.insert(0, params);
      final trimmed = filtered.take(maxItems).toList();
      await _repository.saveLoginHistory(trimmed);
      return trimmed;
    } catch (e) {
      Logger.error('AddLoginHistoryUseCase - error: ${e.toString()}');
      return [];
    }
  }
}
