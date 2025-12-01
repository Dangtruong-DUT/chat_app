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

  static void debug(String message) {
    if (kDebugMode) {
      print('\x1B[36m[${_timestamp()}][DEBUG][${_caller()}] $message\x1B[0m');
    }
  }

  static void warn(String message) {
    if (kDebugMode) {
      print('\x1B[33m[${_timestamp()}][WARNING][${_caller()}] $message\x1B[0m');
    }
  }

  static void error(String message) {
    if (kDebugMode) {
      print('\x1B[31m[${_timestamp()}][ERROR][${_caller()}] $message\x1B[0m');
    }
  }
}
