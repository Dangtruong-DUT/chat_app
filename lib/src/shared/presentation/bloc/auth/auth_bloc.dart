import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/shared/domain/usecases/clear_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/get_current_user.usecase.dart';
import 'package:chat_app/src/shared/domain/usecases/save_current_user.usecase.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_event.dart';
import 'package:chat_app/src/shared/presentation/bloc/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final ClearCurrentUserUseCase clearCurrentUserUseCase;
  final SaveCurrentUserUseCase saveCurrentUserUseCase;

  AuthBloc({
    required this.getCurrentUserUseCase,
    required this.clearCurrentUserUseCase,
    required this.saveCurrentUserUseCase,
  }) : super(AuthLoading()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthLoginRequested>(_onLoginRequested);
  }
  void _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final user = await getCurrentUserUseCase.call(params: null);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  void _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await clearCurrentUserUseCase.call(params: null);
      emit(Unauthenticated());
    } catch (e) {
      Logger.error('AuthBloc - Logout Error: ${e.toString()}');
    }
  }

  void _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await saveCurrentUserUseCase.call(params: event.user);
      emit(Authenticated(event.user));
    } catch (e) {
      Logger.error('AuthBloc - Login Error: ${e.toString()}');
    }
  }
}
