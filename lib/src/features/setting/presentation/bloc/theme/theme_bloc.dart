import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/setting/domain/usecases/get_theme_mode.usecase.dart';
import 'package:chat_app/src/features/setting/domain/usecases/update_theme_mode.usecase.dart';
import 'package:chat_app/src/features/setting/presentation/bloc/theme/theme_event.dart';
import 'package:chat_app/src/features/setting/presentation/bloc/theme/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeModeUseCase _getThemeModeUseCase;
  final UpdateThemeModeUseCase _updateThemeModeUseCase;

  ThemeBloc({
    required GetThemeModeUseCase getThemeModeUseCase,
    required UpdateThemeModeUseCase updateThemeModeUseCase,
  }) : _getThemeModeUseCase = getThemeModeUseCase,
       _updateThemeModeUseCase = updateThemeModeUseCase,
       super(const ThemeState.initial()) {
    on<ThemeModeRequested>(_onThemeModeRequested);
    on<ThemeModeChanged>(_onThemeModeChanged);
  }

  Future<void> _onThemeModeRequested(
    ThemeModeRequested event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(status: ThemeStatus.loading, error: null));
    final result = await _getThemeModeUseCase.call(const NoParams());
    result.fold(
      (error) =>
          emit(state.copyWith(status: ThemeStatus.failure, error: error)),
      (mode) => emit(
        state.copyWith(status: ThemeStatus.ready, mode: mode, error: null),
      ),
    );
  }

  Future<void> _onThemeModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(error: null));
    final result = await _updateThemeModeUseCase.call(
      UpdateThemeModeParams(event.mode),
    );

    result.fold(
      (error) =>
          emit(state.copyWith(status: ThemeStatus.failure, error: error)),
      (mode) => emit(
        state.copyWith(status: ThemeStatus.ready, mode: mode, error: null),
      ),
    );
  }
}
