import 'package:chat_app/src/core/theme/theme_mode.dart';
import 'package:chat_app/src/core/utils/mapper/error.mapper.dart';
import 'package:chat_app/src/core/utils/result/result.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/setting/domain/repositories/theme_repository.dart';
import 'package:easy_localization/easy_localization.dart';

class UpdateThemeModeParams {
  final AppThemeMode mode;

  const UpdateThemeModeParams(this.mode);
}

class UpdateThemeModeUseCase
    extends BaseUseCase<AppThemeMode, UpdateThemeModeParams> {
  final ThemeRepository _repository;

  UpdateThemeModeUseCase({required ThemeRepository repository})
    : _repository = repository;

  @override
  Future<Result<AppThemeMode>> call(UpdateThemeModeParams params) async {
    try {
      await _repository.saveThemeMode(params.mode);
      return success(params.mode);
    } catch (error) {
      return failure(
        ErrorMapper.mapToError(
          error,
          fallbackMessage: tr('errors.settings.updateTheme'),
        ),
      );
    }
  }
}
