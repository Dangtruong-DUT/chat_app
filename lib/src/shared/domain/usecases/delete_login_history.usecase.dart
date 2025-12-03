import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:chat_app/src/shared/domain/repositories/auth_repository.dart';

class DeleteLoginHistoryUseCase implements UseCase<List<User>, String> {
  final AuthRepository repository;

  DeleteLoginHistoryUseCase({required this.repository});

  @override
  Future<List<User>> call({required String params}) async {
    try {
      final current = await repository.getLoginHistory();
      final filtered = current.where((u) => u.id != params).toList();
      await repository.saveLoginHistory(filtered);
      return filtered;
    } catch (e) {
      Logger.error('DeleteLoginHistoryUseCase - error: ${e.toString()}');
      return [];
    }
  }
}
