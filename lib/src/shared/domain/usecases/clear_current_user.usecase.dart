import 'package:chat_app/src/core/utils/usecases/usecase.dart';
import 'package:chat_app/src/shared/domain/repositories/auth_repository.dart';

class ClearCurrentUserUseCase implements UseCase<void, void> {
  final AuthRepository repository;

  ClearCurrentUserUseCase({required this.repository});

  @override
  Future<void> call({required void params}) async {
    await repository.clearLoginData();
  }
}
