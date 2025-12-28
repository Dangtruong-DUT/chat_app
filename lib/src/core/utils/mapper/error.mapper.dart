import 'package:chat_app/src/core/utils/error/base/error.exception.dart';

class ErrorMapper {
  ErrorMapper._();

  static ErrorException mapToError(Object error, {String? fallbackMessage}) {
    if (error is ErrorException) return error;

    final rawMessage = fallbackMessage ?? error.toString();
    final normalized = rawMessage.trim().isEmpty
        ? 'Unexpected error occurred'
        : rawMessage;

    return ErrorException(message: normalized);
  }
}
