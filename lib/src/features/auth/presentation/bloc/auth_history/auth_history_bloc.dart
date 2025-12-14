import 'package:chat_app/src/core/utils/log/logger.dart';
import 'package:chat_app/src/features/auth/domain/usecases/delete_login_history.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/get_login_history.usecase.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/app_auth/app_auth_state.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_history/auth_history_event.dart';
import 'package:chat_app/src/features/auth/presentation/bloc/auth_history/auth_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthHistoryBloc extends Bloc<AuthHistoryEvent, AuthHistoryState> {
  final GetLoginHistoryUseCase _getLoginHistoryUseCase;
  final DeleteLoginHistoryUseCase _deleteLoginHistoryUseCase;

  AuthHistoryBloc({
    required GetLoginHistoryUseCase getLoginHistoryUseCase,
    required DeleteLoginHistoryUseCase deleteLoginHistoryUseCase,
  }) : _getLoginHistoryUseCase = getLoginHistoryUseCase,
       _deleteLoginHistoryUseCase = deleteLoginHistoryUseCase,
       super(const AuthHistoryInitial()) {
    on<AuthHistoryFetchRequested>(_onAuthHistoryFetchRequested);
    on<AuthHistoryDeleteItemRequested>(_onAuthHistoryDeleteItemRequested);
  }

  void _onAuthHistoryFetchRequested(
    AuthHistoryFetchRequested event,
    Emitter<AuthHistoryState> emit,
  ) async {
    try {
      emit(const AuthHistoryLoading());
      final history = await _getLoginHistoryUseCase.call(params: null);

      emit(AuthHistoryLoaded(history: history));
    } catch (e) {
      Logger.error(
        'AuthHistoryBloc - Fetch Login History Error: ${e.toString()}',
      );
      emit(const AuthHistoryLoaded(history: []));
    }
  }

  void _onAuthHistoryDeleteItemRequested(
    AuthHistoryDeleteItemRequested event,
    Emitter<AuthHistoryState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is! AppUnauthenticated) return;

      final updatedHistory = await _deleteLoginHistoryUseCase.call(
        params: event.id,
      );
      emit(AuthHistoryLoaded(history: updatedHistory));
    } catch (e) {
      Logger.error(
        'AuthHistoryBloc - Delete Login History Error: ${e.toString()}',
      );
      emit(const AuthHistoryLoaded(history: []));
    }
  }
}
