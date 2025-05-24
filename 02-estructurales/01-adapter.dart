// import 'adapter-files/local-logger.dart';
import 'adapter-files/logger-adapter.dart';

/**
 * ! Patrón Adapter
 *  Permite que objetos con interfaces incompatibles trabajen juntos, también es muy
 *  util para utilizar librerías de terceros en nuestra aplicación sin depender
 *  directamente de ellas.
 *
 * * Es útil cuando se quiere reutilizar una clase que no tiene la interfaz que
 * * necesitamos o cuando queremos crear una capa de abstracción para una librería
 * * de terceros.
 *
 * https://refactoring.guru/es/design-patterns/adapter
 */

void main(List<String> args) {
  // final logger = LocalLogger(file: '01-adapter.dart');
  final logger = PackageLoggerAdapter(file: '01-adapter.dart');

  // Imagine we have this kind of logs across a big amount of files
  // in the app
  logger.writeLog('This is a Log');
  logger.writeError('This is a Error');
  logger.writeWarning('This is a Warning');
}
