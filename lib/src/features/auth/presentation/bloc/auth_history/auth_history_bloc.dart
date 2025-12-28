import 'package:chat_app/src/core/utils/usecases/base_usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/delete_login_history.usecase.dart';
import 'package:chat_app/src/features/auth/domain/usecases/get_login_history.usecase.dart';
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
       super(AuthHistoryState.initial()) {
    on<AuthHistoryFetchRequested>(_onFetch);
    on<AuthHistoryDeleteItemRequested>(_onDelete);
  }

  Future<void> _onFetch(
    AuthHistoryFetchRequested event,
    Emitter<AuthHistoryState> emit,
  ) async {
    emit(state.copyWith(status: AuthHistoryStatus.loading));

    final result = await _getLoginHistoryUseCase.call(const NoParams());
    result.fold(
      (error) =>
          emit(state.copyWith(status: AuthHistoryStatus.failure, error: error)),
      (history) => emit(
        state.copyWith(
          status: AuthHistoryStatus.success,
          history: history,
          error: null,
        ),
      ),
    );
  }

  Future<void> _onDelete(
    AuthHistoryDeleteItemRequested event,
    Emitter<AuthHistoryState> emit,
  ) async {
    final result = await _deleteLoginHistoryUseCase.call(event.id);
    result.fold(
      (error) =>
          emit(state.copyWith(status: AuthHistoryStatus.failure, error: error)),
      (history) => emit(
        state.copyWith(status: AuthHistoryStatus.success, history: history),
      ),
    );
  }
}
