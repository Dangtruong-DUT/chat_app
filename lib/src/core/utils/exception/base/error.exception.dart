class ErrorException implements Exception {
  final String message;
  final String details;
  final String code;

  const ErrorException({
    this.message = 'An unknown error occurred.',
    this.details = "",
    this.code = "UNKNOWN_ERROR",
  });

  @override
  String toString() => 'ErrorException: $message';
}
