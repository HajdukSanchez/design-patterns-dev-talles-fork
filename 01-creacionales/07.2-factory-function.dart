/**
 * ! Factory Function
 * Es un patrón de diseño que nos permite crear objetos o funciones de manera dinámica que serán
 * usados posteriormente en el código.
 *
 * * Es útil cuando necesitamos crear objetos o funciones de manera dinámica,
 * * es decir, en tiempo de ejecución y no en tiempo de compilación.
 *
 */

//! Salida esperada
//! Colocar colores de log según el nivel
//* [INFO:2025-10-21:07] Aplicación iniciada correctamente.
//* [WARNING:2025-10-21:07] El uso de memoria está alto.
//* [ERROR:2025-10-21:07] Error de conexión a la base de datos.

String formatDate(DateTime date) {
  final year = date.year;
  final month = date.month;
  final day = date.day;
  final hours = date.hour;
  final minutes = date.minute;
  final seconds = date.second;

  return '${year}-${month}-${day} ${hours}:${minutes}:${seconds}';
}

enum LogLevel { info, warn, error }

typedef LoggerFunction = void Function(String message);

LoggerFunction createLogger(LogLevel level) {
  return (String message) {
    final date = formatDate(DateTime.now());
    final logMessage = switch (level) {
      LogLevel.error => '[ERROR:$date] $message',
      LogLevel.info => '[INFO:$date] $message',
      LogLevel.warn => '[WARN:$date] $message',
    };
    print(logMessage);
  };
}

void main(List<String> args) {
  final infoLogger = createLogger(LogLevel.info);
  final warnLogger = createLogger(LogLevel.warn);
  final errorLogger = createLogger(LogLevel.error);

  infoLogger('Application started properly');
  warnLogger('Heavy memory usage');
  errorLogger('Error on data base connection');
}
