import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:chat_app/src/shared/domain/repositories/auth_repository.dart';

class GetLoginHistoryUseCase implements BaseUseCase<List<User>, void> {
  final AuthRepository repository;

  GetLoginHistoryUseCase({required this.repository});

  @override
  Future<List<User>> call({required void params}) async {
    try {
      final users = await repository.getLoginHistory();
      return users;
    } catch (e) {
      return [];
    }
  }
}
