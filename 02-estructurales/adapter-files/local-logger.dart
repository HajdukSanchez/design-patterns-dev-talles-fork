import 'logger-adapter.dart';

final class LocalLogger implements ILoggerAdapter {
  LocalLogger({required this.file});

  final String file;

  @override
  String get fileName => file;

  @override
  void writeLog(String message) {
    print('[$file] Log: $message');
  }

  @override
  void writeError(String message) {
    print('[$file] Error: $message');
  }

  @override
  void writeWarning(String message) {
    print('[$file] Warning: $message');
  }
}
