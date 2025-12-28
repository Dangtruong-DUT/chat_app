import 'package:chat_app/src/core/utils/error/base/error.exception.dart';

class ErrorMapper {
  ErrorMapper._();

  static ErrorException mapToError(Object error, {String? fallbackMessage}) {
    if (error is ErrorException) return error;

    final normalized = error.toString().isEmpty
        ? fallbackMessage ?? 'Unexpected error occurred'
        : error.toString();

    return ErrorException(message: normalized);
  }
}
