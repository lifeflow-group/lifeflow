import 'package:flutter/foundation.dart';
import '../config/environment.dart';

enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
}

class AppLogger {
  final String tag;
  final bool _isDebug = Environment.isDebug;

  AppLogger(this.tag);

  void verbose(String message) {
    _log(LogLevel.verbose, message);
  }

  void debug(String message) {
    _log(LogLevel.debug, message);
  }

  void info(String message) {
    _log(LogLevel.info, message);
  }

  void warning(String message) {
    _log(LogLevel.warning, message);
  }

  void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _log(LogLevel.error, message, error, stackTrace);
  }

  void _log(LogLevel level, String message, [dynamic error, StackTrace? stackTrace]) {
    if (!_isDebug && level != LogLevel.error) return;

    final now = DateTime.now().toIso8601String();
    final levelStr = level.toString().split('.').last.toUpperCase();
    
    debugPrint('[$now] $levelStr [$tag] - $message');
    
    if (error != null) {
      debugPrint('Error details: $error');
    }
    
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
  }
}