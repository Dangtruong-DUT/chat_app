import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repositories.dart';

class ClearCurrentUserUseCase implements BaseUseCase<void, void> {
  final AuthRepository _repository;

  ClearCurrentUserUseCase({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<void> call({required void params}) async {
    try {
      await _repository.clearLoginData();
    } catch (e) {
      Logger.error('ClearCurrentUserUseCase - error: ${e.toString()}');
    }
  }
}
