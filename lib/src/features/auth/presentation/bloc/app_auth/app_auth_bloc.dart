import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/auth/domain/usecases/add_login_history.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/clear_current_user.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/delete_login_history.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/get_current_user.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/get_login_history.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/save_current_user.usecase.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_state.dart';
import 'package:chat_app/src/features/user/domain/entities/user.entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppAuthBloc extends Bloc<AppAuthEvent, AppAuthState> {
  final GetCurrentUserUseCase _getCurrentUserUseCase;
  final ClearCurrentUserUseCase _clearCurrentUserUseCase;
  final SaveCurrentUserUseCase _saveCurrentUserUseCase;
  final GetLoginHistoryUseCase _getLoginHistoryUseCase;
  final AddLoginHistoryUseCase _addLoginHistoryUseCase;
  final DeleteLoginHistoryUseCase _deleteLoginHistoryUseCase;

  AppAuthBloc({
    required GetCurrentUserUseCase getCurrentUserUseCase,
    required ClearCurrentUserUseCase clearCurrentUserUseCase,
    required SaveCurrentUserUseCase saveCurrentUserUseCase,
    required GetLoginHistoryUseCase getLoginHistoryUseCase,
    required AddLoginHistoryUseCase addLoginHistoryUseCase,
    required DeleteLoginHistoryUseCase deleteLoginHistoryUseCase,
  }) : _getCurrentUserUseCase = getCurrentUserUseCase,
       _clearCurrentUserUseCase = clearCurrentUserUseCase,
       _saveCurrentUserUseCase = saveCurrentUserUseCase,
       _getLoginHistoryUseCase = getLoginHistoryUseCase,
       _addLoginHistoryUseCase = addLoginHistoryUseCase,
       _deleteLoginHistoryUseCase = deleteLoginHistoryUseCase,
       super(const AppAuthLoading()) {
    on<AppAuthCheckRequested>(_onAuthCheckRequested);
    on<AppAuthLogoutRequested>(_onLogoutRequested);
    on<AppAuthLoginRequested>(_onLoginRequested);
    on<AppAuthDeleteLoginHistoryRequested>(_onDeleteLoginHistoryRequested);
  }
  void _onAuthCheckRequested(
    AppAuthCheckRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    try {
      emit(const AppAuthLoading());

      final results = await Future.wait([
        _getLoginHistoryUseCase.call(params: null),
        _getCurrentUserUseCase.call(params: null),
      ]);

      Logger.debug(results[0].runtimeType.toString());
      final history = results[0] as List<User>;
      final user = results[1] as User?;

      if (user != null) {
        emit(AppAuthenticated(user));
      } else {
        emit(AppUnauthenticated(loginHistory: history));
      }
    } catch (e) {
      Logger.error('AuthBloc - AuthCheck Error: ${e.toString()}');
      emit(AppUnauthenticated(loginHistory: []));
    }
  }

  void _onLogoutRequested(
    AppAuthLogoutRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    try {
      final results = await Future.wait([
        _getLoginHistoryUseCase.call(params: null),
        _clearCurrentUserUseCase.call(params: null).then((_) => null),
      ]);
      emit(AppUnauthenticated(loginHistory: results[0] as List<User>));
    } catch (e) {
      Logger.error('AuthBloc - Logout Error: ${e.toString()}');
    }
  }

  void _onLoginRequested(
    AppAuthLoginRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    try {
      await Future.wait([
        _addLoginHistoryUseCase.call(params: event.user),
        _saveCurrentUserUseCase.call(params: event.user),
      ]);
      emit(AppAuthenticated(event.user));
    } catch (e) {
      Logger.error('AuthBloc - Login Error: ${e.toString()}');
    }
  }

  void _onDeleteLoginHistoryRequested(
    AppAuthDeleteLoginHistoryRequested event,
    Emitter<AppAuthState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! AppUnauthenticated) return;

      final updatedHistory = await _deleteLoginHistoryUseCase.call(
        params: event.id,
      );
      emit(AppUnauthenticated(loginHistory: updatedHistory));
    } catch (e) {
      Logger.error('AuthBloc - Delete Login History Error: ${e.toString()}');
    }
  }
}
