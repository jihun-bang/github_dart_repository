import 'package:logger/logger.dart' as l;

class Logger {
  Logger._();

  static final l.Logger _logger = l.Logger(
    printer: l.PrettyPrinter(
      printTime: true,
    ),
  );

  static void d(dynamic message) {
    _logger.d(message);
  }

  static void e(dynamic message, [Object? error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
