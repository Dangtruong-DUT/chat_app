import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/add_login_history.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/clear_current_user.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/get_current_user.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/save_current_user.usecase.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final ClearCurrentUserUseCase _clearCurrentUserUseCase;
  final SaveCurrentUserUseCase _saveCurrentUserUseCase;
  final AddLoginHistoryUseCase _addLoginHistoryUseCase;

  AppAuthBloc({
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required ClearCurrentUserUseCase clearCurrentUserUseCase,
    required SaveCurrentUserUseCase saveCurrentUserUseCase,
    required AddLoginHistoryUseCase addLoginHistoryUseCase,
  }) : _getCurrentUserUseCase = getCurrentUserUseCase,
       _clearCurrentUserUseCase = clearCurrentUserUseCase,
       _saveCurrentUserUseCase = saveCurrentUserUseCase,
       _addLoginHistoryUseCase = addLoginHistoryUseCase,
       super(const AppAuthState.initial()) {
    on<AppAuthCheckRequested>(_onAuthCheckRequested);
    on<AppAuthLogoutRequested>(_onLogoutRequested);
    on<AppAuthLoginRequested>(_onLoginRequested);
  }
  Future<void> _onAuthCheckRequested(
    AppAuthCheckRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    emit(const AppAuthState.loading());
    final result = await _getCurrentUserUseCase.call(const NoParams());

    await result.fold<Future<void>>(
      (error) async {
        emit(
          state.copyWith(
            status: AppAuthStatus.unauthenticated,
            error: error,
            clearUser: true,
          ),
        );
        await _clearCurrentUserUseCase.call(const NoParams());
      },
      (user) async {
        if (user != null) {
          emit(AppAuthState.authenticated(user));
        } else {
          emit(const AppAuthState.unauthenticated());
        }
      },
    );
  }

  Future<void> _onLogoutRequested(
    AppAuthLogoutRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    final result = await _clearCurrentUserUseCase.call(const NoParams());
    result.fold(
      (error) => emit(state.copyWith(error: error)),
      (_) => emit(const AppAuthState.unauthenticated()),
    );
  }

  Future<void> _onLoginRequested(
    AppAuthLoginRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    final saveResult = await _saveCurrentUserUseCase.call(event.user);

    await saveResult.fold<Future<void>>(
      (error) async {
        emit(
          state.copyWith(
            status: AppAuthStatus.unauthenticated,
            error: error,
            clearUser: true,
          ),
        );
      },
      (_) async {
        emit(AppAuthState.authenticated(event.user));
        final historyResult = await _addLoginHistoryUseCase.call(event.user);
        historyResult.fold(
          (error) =>
              Logger.warn('Login history update failed: ${error.message}'),
          (_) {},
        );
      },
    );
  }
}
