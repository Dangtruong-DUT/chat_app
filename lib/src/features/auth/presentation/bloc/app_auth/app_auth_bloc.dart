import 'package:chat_app/src/core/utils/log/logger.dart';
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
  void _onAuthCheckRequested(
    AppAuthCheckRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    try {
      emit(const AppAuthLoading());

      final user = await _getCurrentUserUseCase.call(params: null);

      if (user != null) {
        emit(AppAuthenticated(user));
      } else {
        emit(const AppUnauthenticated());
      }
    } catch (e) {
      Logger.error('AuthBloc - AuthCheck Error: ${e.toString()}');
      emit(const AppUnauthenticated());
      await _clearCurrentUserUseCase.call(params: null);
    }
  }

  void _onLogoutRequested(
    AppAuthLogoutRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    try {
      await _clearCurrentUserUseCase.call(params: null);
      emit(const AppUnauthenticated());
    } catch (e) {
      Logger.error('AuthBloc - Logout Error: ${e.toString()}');
    }
  }

  void _onLoginRequested(
    AppAuthLoginRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    try {
      await _saveCurrentUserUseCase.call(params: event.user);
      emit(AppAuthenticated(event.user));
    } catch (e) {
      Logger.error('AuthBloc - Login Error: ${e.toString()}');
    }
  }
}
