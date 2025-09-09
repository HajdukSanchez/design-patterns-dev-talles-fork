/**
 * ! Patrón Strategy
 *
 * El patrón Strategy es un patrón de diseño de software que define una
 * familia de algoritmos, los encapsula y los hace intercambiables.
 *
 *
 * * Es útil cuando se tiene una clase que tiene un comportamiento que puede
 * * cambiar en tiempo de ejecución y se quiere delegar la responsabilidad de
 * * la implementación a otra clase.
 *
 * https://refactoring.guru/es/design-patterns/strategy
 */

/**
 * !Objetivo: Explicar el patrón Strategy usando un ejemplo donde varios
 * ! patitos compiten en una carrera y cada uno tiene su propia
 * ! estrategia de movimiento (por ejemplo, nadar, volar o caminar).
 */

abstract interface class MovementStrategy {
  void move();
}

final class SwingStrategy implements MovementStrategy {
  @override
  void move() {
    print('Swimming');
  }
}

final class FlyOverWaterStrategy implements MovementStrategy {
  @override
  void move() {
    print('Flying over water');
  }
}

final class WalkStrategy implements MovementStrategy {
  @override
  void move() {
    print('Walking');
  }
}

final class Duck {
  Duck({required this.name, required this.movementStrategy}) {
    print(
      'Duck [$name]: Ready to compete with ${movementStrategy.runtimeType}',
    );
  }

  final String name;
  MovementStrategy movementStrategy;

  setMovementStrategy(MovementStrategy movementStrategy) {
    this.movementStrategy = movementStrategy;
    print(
      'Duck [$name]: Change movement strategy ${movementStrategy.runtimeType}',
    );
  }
}

void main(List<String> args) {
  final duck = Duck(name: 'Duck 1', movementStrategy: SwingStrategy());
  final duck2 = Duck(name: 'Duck 2', movementStrategy: FlyOverWaterStrategy());
  final duck3 = Duck(name: 'Duck 3', movementStrategy: WalkStrategy());

  // Start duck competition
  duck.movementStrategy.move();
  duck2.movementStrategy.move();
  duck3.movementStrategy.move();

  duck3.setMovementStrategy(FlyOverWaterStrategy());
  duck3.movementStrategy.move();
}
