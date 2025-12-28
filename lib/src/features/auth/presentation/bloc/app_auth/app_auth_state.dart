import 'package:chat_app/src/core/utils/error/base/error.exception.dart';
import 'package:chat_app/src/shared/domain/entities/user.entity.dart';

enum AppAuthStatus { initial, loading, authenticated, unauthenticated }

class AppAuthState {
  final AppAuthStatus status;
  final User? user;
  final ErrorException? error;

  const AppAuthState({required this.status, this.user, this.error});

  const AppAuthState.initial() : this(status: AppAuthStatus.initial);

  const AppAuthState.loading() : this(status: AppAuthStatus.loading);

  const AppAuthState.authenticated(User user)
    : this(status: AppAuthStatus.authenticated, user: user);

  const AppAuthState.unauthenticated()
    : this(status: AppAuthStatus.unauthenticated);

  AppAuthState copyWith({
    AppAuthStatus? status,
    User? user,
    ErrorException? error,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AppAuthState(
      status: status ?? this.status,
      user: clearUser ? null : user ?? this.user,
      error: clearError ? null : error ?? this.error,
    );
  }

  bool get isAuthenticated =>
      status == AppAuthStatus.authenticated && user != null;
}
