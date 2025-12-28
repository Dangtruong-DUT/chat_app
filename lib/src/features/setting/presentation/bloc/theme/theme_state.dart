import 'package:chat_app/src/core/theme/theme_mode.dart';
import 'package:chat_app/src/core/utils/error/base/error.exception.dart';
import 'package:equatable/equatable.dart';

enum ThemeStatus { initial, loading, ready, failure }

class ThemeState extends Equatable {
  static const Object _undefined = Object();

  final ThemeStatus status;
  final AppThemeMode mode;
  final ErrorException? error;

  const ThemeState({required this.status, required this.mode, this.error});

  const ThemeState.initial()
    : this(status: ThemeStatus.initial, mode: AppThemeMode.system);

  ThemeState copyWith({
    ThemeStatus? status,
    AppThemeMode? mode,
    Object? error = _undefined,
  }) {
    return ThemeState(
      status: status ?? this.status,
      mode: mode ?? this.mode,
      error: identical(error, _undefined)
          ? this.error
          : error as ErrorException?,
    );
  }

  bool get isReady => status == ThemeStatus.ready;
  bool get hasError => error != null;

  @override
  List<Object?> get props => <Object?>[status, mode, error];
}
