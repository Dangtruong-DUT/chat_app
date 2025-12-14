import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:chat_app/src/shared/domain/repositories/auth_repository.dart';

class DeleteLoginHistoryUseCase implements BaseUseCase<List<User>, String> {
  final AuthRepository _repository;

  DeleteLoginHistoryUseCase({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<List<User>> call({required String params}) async {
    try {
      final current = await _repository.getLoginHistory();
      final filtered = current.where((u) => u.id != params).toList();
      await _repository.saveLoginHistory(filtered);
      return filtered;
    } catch (e) {
      Logger.error('DeleteLoginHistoryUseCase - error: ${e.toString()}');
      return [];
    }
  }
}
