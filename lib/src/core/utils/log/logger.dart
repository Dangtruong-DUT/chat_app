import 'package:flutter/foundation.dart';

class Logger {
  Logger._();

  static String _timestamp() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';
  }

  static String _caller() {
    try {
      final trace = StackTrace.current.toString().split('\n')[2];
      final regex = RegExp(r'(\w+\.dart):(\d+)');
      final match = regex.firstMatch(trace);
      if (match != null) {
        return '${match.group(1)}:${match.group(2)}';
      }
    } catch (_) {}
    return 'unknown';
  }

  static void _log(String level, String message, String color) {
    if (!kDebugMode) return;

    final lines = message.split('\n');
    for (var line in lines) {
      print('$color[${_timestamp()}][$level][${_caller()}] $line\x1B[0m');
    }
  }

  static void debug(String message) => _log('DEBUG', message, '\x1B[36m');
  static void warn(String message) => _log('WARNING', message, '\x1B[33m');
  static void error(String message) => _log('ERROR', message, '\x1B[31m');
}
