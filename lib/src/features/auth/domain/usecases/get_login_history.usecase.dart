import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';
import 'package:easy_localization/easy_localization.dart';

class GetLoginHistoryUseCase extends BaseUseCase<List<User>, NoParams> {
  final AuthRepository _repository;

  GetLoginHistoryUseCase({required AuthRepository repository})
    : _repository = repository;

  @override
  Future<Result<List<User>>> call(NoParams params) async {
    try {
      final history = await _repository.getLoginHistory();
      Logger.debug('Fetched login history: $history');
      return success(history);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(
          error,
          fallbackMessage: tr('errors.auth.fetchHistory'),
        ),
      );
    }
  }
}
