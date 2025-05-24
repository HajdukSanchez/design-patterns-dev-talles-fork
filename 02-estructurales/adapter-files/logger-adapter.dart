/// Imagine this is a class from a third party library
class PackageLogger {
  void info(String message) {
    print('[${DateTime.now()}] Info: $message');
  }

  void error(String message) {
    print('[${DateTime.now()}] Error: $message');
  }

  void warning(String message) {
    print('[${DateTime.now()}] Warning: $message');
  }
}

/// -------------------------------------
/// -------------------------------------
/// -------------------------------------

abstract interface class ILoggerAdapter {
  String get fileName;

  void writeLog(String message);

  void writeError(String message);

  void writeWarning(String message);
}

final class PackageLoggerAdapter implements ILoggerAdapter {
  PackageLoggerAdapter({required this.file});

  final String file;

  PackageLogger get _packageLogger => PackageLogger();

  @override
  String get fileName => file;

  @override
  void writeLog(String message) {
    _packageLogger.info('[$fileName] $message');
  }

  @override
  void writeError(String message) {
    _packageLogger.error('[$fileName] $message');
  }

  @override
  void writeWarning(String message) {
    _packageLogger.warning('[$fileName] $message');
  }
}
