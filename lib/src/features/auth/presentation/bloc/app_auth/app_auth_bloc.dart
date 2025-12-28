import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
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

  AppAuthBloc({
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required ClearCurrentUserUseCase clearCurrentUserUseCase,
    required SaveCurrentUserUseCase saveCurrentUserUseCase,
  }) : _getCurrentUserUseCase = getCurrentUserUseCase,
       _clearCurrentUserUseCase = clearCurrentUserUseCase,
       _saveCurrentUserUseCase = saveCurrentUserUseCase,
       super(const AppAuthLoading()) {
    on<AppAuthCheckRequested>(_onAuthCheckRequested);
    on<AppAuthLogoutRequested>(_onLogoutRequested);
    on<AppAuthLoginRequested>(_onLoginRequested);
  }
  Future<void> _onAuthCheckRequested(
    AppAuthCheckRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    emit(const AppAuthLoading());
    final result = await _getCurrentUserUseCase.call(const NoParams());

    await result.fold<Future<void>>(
      (error) async {
        emit(AppAuthFailure(error: error));
        emit(const AppUnauthenticated());
        await _clearCurrentUserUseCase.call(const NoParams());
      },
      (user) async {
        if (user != null) {
          emit(AppAuthenticated(user));
        } else {
          emit(const AppUnauthenticated());
        }
      },
    );
  }

  Future<void> _onLogoutRequested(
    AppAuthLogoutRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    final result = await _clearCurrentUserUseCase.call(const NoParams());
    result.fold((error) => emit(AppAuthFailure(error: error)), (_) {});
    emit(const AppUnauthenticated());
  }

  Future<void> _onLoginRequested(
    AppAuthLoginRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    final result = await _saveCurrentUserUseCase.call(event.user);
    result.fold((error) {
      emit(AppAuthFailure(error: error));
      emit(const AppUnauthenticated());
    }, (_) => emit(AppAuthenticated(event.user)));
  }
}
