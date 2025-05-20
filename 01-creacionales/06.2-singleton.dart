/**
 * ! Singleton:
 * Es un patrón de diseño creacional que garantiza que una clase
 * tenga una única instancia y proporciona un punto de acceso global a ella.
 *
 * * Es útil cuando necesitas controlar el acceso a una única instancia
 * * de una clase, como por ejemplo, en un objeto de base de datos o en un
 * * objeto de configuración.
 */

class DatabaseConnection {
  DatabaseConnection._();

  static DatabaseConnection _instance = DatabaseConnection._();
  static DatabaseConnection get instance => _instance;

  static bool _connected = false;
  static bool get connected => _connected;

  void connect() {
    if (_connected) {
      print('There is already a connection stablish');
      return;
    }
    _connected = true;
    print('Connection stablish');
  }

  void disconnect() {
    if (_connected) {
      _connected = false;
      print('Data Base connection closed');
      return;
    }

    print('There is no connection stablish to close');
  }
}

void main(List<String> args) {
  final db1 = DatabaseConnection.instance;
  db1.connect();

  final db2 = DatabaseConnection.instance;
  db2.connect();

  print('Equals: ${db1 == db2}');

  db1.disconnect();
  db2.disconnect();
  db2.connect();
}
