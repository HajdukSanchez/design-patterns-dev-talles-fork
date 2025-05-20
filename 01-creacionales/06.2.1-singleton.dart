/**
 * ! Singleton:
 * Es un patrón de diseño creacional que garantiza que una clase
 * tenga una única instancia y proporciona un punto de acceso global a ella.
 *
 * * Es útil cuando necesitas controlar el acceso a una única instancia
 * * de una clase, como por ejemplo, en un objeto de base de datos o en un
 * * objeto de configuración.
 *
 * https://refactoring.guru/es/design-patterns/singleton
 */
class _ConfigManager {
  static Map<String, String> _config = {};

  void setConfig({required String key, required String value}) {
    _config[key] = value;
  }

  String? getConfig({required String key}) {
    return _config[key];
  }

  Map<String, String> getAllConfig() {
    return _config;
  }
}

final configManager = _ConfigManager();

void main(List<String> args) {
  configManager.setConfig(key: 'a', value: '1');
  configManager.setConfig(key: 'b', value: '2');
  configManager.setConfig(key: 'c', value: '3');

  print(configManager.getAllConfig());
}
