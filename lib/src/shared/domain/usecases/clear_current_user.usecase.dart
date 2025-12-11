import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/shared/domain/repositories/auth_repository.dart';

class ClearCurrentUserUseCase implements BaseUseCase<void, void> {
  final AuthRepository repository;

  ClearCurrentUserUseCase({required this.repository});

  @override
  Future<void> call({required void params}) async {
    try {
      await repository.clearLoginData();
    } catch (e) {
      Logger.error('ClearCurrentUserUseCase - error: ${e.toString()}');
    }
  }
}
