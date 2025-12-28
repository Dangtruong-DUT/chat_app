import 'package:chat_app/src/core/utils/error/base/error.exception.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';
import 'package:equatable/equatable.dart';

enum AuthHistoryStatus { initial, loading, success, failure }

class AuthHistoryState extends Equatable {
  final List<User> history;
  final AuthHistoryStatus status;
  final ErrorException? error;
  static const Object _errorSentinel = Object();

  @override
  List<Object?> get props => [history, status, error];

  const AuthHistoryState({
    this.history = const [],
    this.status = AuthHistoryStatus.initial,
    this.error,
  });

  factory AuthHistoryState.initial() {
    return const AuthHistoryState(
      status: AuthHistoryStatus.initial,
      history: [],
    );
  }

  AuthHistoryState copyWith({
    List<User>? history,
    AuthHistoryStatus? status,
    Object? error = _errorSentinel,
  }) {
    return AuthHistoryState(
      history: history ?? this.history,
      status: status ?? this.status,
      error: identical(error, _errorSentinel)
          ? this.error
          : error as ErrorException?,
    );
  }
}
