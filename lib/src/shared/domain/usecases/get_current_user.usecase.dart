import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:chat_app/src/shared/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase implements UseCase<User?, void> {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  @override
  Future<User?> call({required void params}) async {
    Logger.debug('Getting current user');
    return await repository.getLoginData();
  }
}
