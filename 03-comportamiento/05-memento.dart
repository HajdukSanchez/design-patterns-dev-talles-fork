/**
 * !Patrón Memento
 * Permite capturar y externalizar un estado interno de un objeto,
 * de manera que el objeto pueda ser restaurado a ese estado más tarde.
 *
 * * Es útil cuando se necesita guardar el estado de un objeto para poder
 * * volver a él en un futuro.
 *
 * https://refactoring.guru/es/design-patterns/memento
 */
final class GameMemento {
  GameMemento({
    required this.level,
    required this.health,
    required this.position,
  });

  final int level;
  final int health;
  final String position;
}

final class Game {
  Game({required this.level, required this.health, required this.position}) {
    _playLog();
  }

  int level;
  int health;
  String position;

  GameMemento save() {
    return GameMemento(level: level, health: health, position: position);
  }

  void updateProgress(int level, int health, String position) {
    this.level = level;
    this.health = health;
    this.position = position;

    print('Updating progress...');
    _playLog();
  }

  void restore(GameMemento memento) {
    this.level = memento.level;
    this.health = memento.health;
    this.position = memento.position;

    print('Restoring progress...');
    _playLog();
  }

  void _playLog() {
    print('Playing at level: $level, health: $health, position: $position');
  }
}

final class GameHistory {
  final List<GameMemento> _mementos = [];

  void push(GameMemento memento) {
    _mementos.add(memento);
  }

  GameMemento? pop() {
    return _mementos.lastOrNull;
  }
}

void main(List<String> args) {
  final game = Game(level: 1, health: 100, position: 'Start');
  final gameHistory = GameHistory();

  gameHistory.push(game.save());
  // Still playing
  game.updateProgress(2, 90, 'Ocean');
  gameHistory.push(game.save());
  // Still playing
  game.updateProgress(3, 80, 'Mountain');
  gameHistory.push(game.save());
  // Still playing
  game.updateProgress(4, 20, 'Dragon');
  print('Loss the game....');

  // Restoring
  final lastCheck = gameHistory.pop();
  if (lastCheck != null) {
    game.restore(lastCheck);
  }
}
