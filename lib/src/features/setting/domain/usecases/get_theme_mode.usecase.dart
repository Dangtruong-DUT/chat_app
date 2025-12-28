import 'package:chat_app/src/core/theme/theme_mode.dart';
import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/setting/domain/repositories/theme_repository.dart';
import 'package:easy_localization/easy_localization.dart';

class GetThemeModeUseCase extends BaseUseCase<AppThemeMode, NoParams> {
  final ThemeRepository _repository;

  GetThemeModeUseCase({required ThemeRepository repository})
    : _repository = repository;

  @override
  Future<Result<AppThemeMode>> call(NoParams params) async {
    try {
      final mode = await _repository.getThemeMode();
      return success(mode);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(
          error,
          fallbackMessage: tr('errors.settings.loadTheme'),
        ),
      );
    }
  }
}
