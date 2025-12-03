import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/shared/domain/models/user.model.dart';
import 'package:chat_app/src/shared/domain/usecases/clear_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/get_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/save_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/get_login_history.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/add_login_history.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/delete_login_history.usecase.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_event.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final ClearCurrentUserUseCase clearCurrentUserUseCase;
  final SaveCurrentUserUseCase saveCurrentUserUseCase;
  final GetLoginHistoryUseCase getLoginHistoryUseCase;
  final AddLoginHistoryUseCase addLoginHistoryUseCase;
  final DeleteLoginHistoryUseCase deleteLoginHistoryUseCase;

  AuthBloc({
    required this.getCurrentUserUseCase,
    required this.clearCurrentUserUseCase,
    required this.saveCurrentUserUseCase,
    required this.getLoginHistoryUseCase,
    required this.addLoginHistoryUseCase,
    required this.deleteLoginHistoryUseCase,
  }) : super(const AuthLoading()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthDeleteLoginHistoryRequested>(_onDeleteLoginHistoryRequested);
  }
  void _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(const AuthLoading());

      final results = await Future.wait([
        getLoginHistoryUseCase.call(params: null),
        getCurrentUserUseCase.call(params: null),
      ]);

      Logger.debug(results[0].runtimeType.toString());
      final history = results[0] as List<User>;
      final user = results[1] as User?;

      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated(loginHistory: history));
      }
    } catch (e) {
      Logger.error('AuthBloc - AuthCheck Error: ${e.toString()}');
      emit(Unauthenticated(loginHistory: []));
    }
  }

  void _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final results = await Future.wait([
        getLoginHistoryUseCase.call(params: null),
        clearCurrentUserUseCase.call(params: null).then((_) => null),
      ]);
      emit(Unauthenticated(loginHistory: results[0] as List<User>));
    } catch (e) {
      Logger.error('AuthBloc - Logout Error: ${e.toString()}');
    }
  }

  void _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await Future.wait([
        addLoginHistoryUseCase.call(params: event.user),
        saveCurrentUserUseCase.call(params: event.user),
      ]);
      emit(Authenticated(event.user));
    } catch (e) {
      Logger.error('AuthBloc - Login Error: ${e.toString()}');
    }
  }

  void _onDeleteLoginHistoryRequested(
    AuthDeleteLoginHistoryRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! Unauthenticated) return;

      final updatedHistory = await deleteLoginHistoryUseCase.call(
        params: event.id,
      );
      emit(Unauthenticated(loginHistory: updatedHistory));
    } catch (e) {
      Logger.error('AuthBloc - Delete Login History Error: ${e.toString()}');
    }
  }
}
