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

class DragonBalls {
  /// Private constructor to avoid initialization
  DragonBalls._() {
    // Initialization of properties internally
    _collectedBalls = 0;
  }

  static final DragonBalls _instance = DragonBalls._();
  static DragonBalls get instance => _instance;
  static DragonBalls get I => _instance;
  static DragonBalls get i => _instance;

  late int _collectedBalls;
  final _totalBalls = 7;

  void collectBall() {
    if (_collectedBalls < _totalBalls) {
      _collectedBalls++;
      print('Collected balls: ${_collectedBalls}');
      return;
    }

    print('All balls already collected: $_totalBalls/${_collectedBalls}');
  }
}

void main(List<String> args) {
  // Throw error: final dragonBalls = DragonBalls();
  final dragonBalls1 = DragonBalls.instance;
  final dragonBalls2 = DragonBalls.I;
  final dragonBalls3 = DragonBalls.i;

  dragonBalls1
    ..collectBall()
    ..collectBall()
    ..collectBall();

  dragonBalls2
    ..collectBall()
    ..collectBall();

  dragonBalls3
    ..collectBall()
    ..collectBall()
    ..collectBall()
    ..collectBall()
    ..collectBall()
    ..collectBall();
}
