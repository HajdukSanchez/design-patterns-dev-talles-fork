/**
 * ! Inmutabilidad con copia
 * Aunque la inmutabilidad es una buena práctica, no siempre es posible.
 * En estos casos, se puede hacer una copia del objeto y modificar la copia.
 *
 *  * Es útil para mantener un historial de estados en aplicaciones interactivas.
 *
 */

/**
 1.	Completen el método copyWith en la clase Player para que permita
 crear una copia con cambios en name, score o level.

 2.	Usen el código cliente para probar el funcionamiento de copyWith,
 haciendo cambios en el puntaje, nivel y nombre del jugador.
 */

class Player {
  Player({required this.name, required this.score, required this.level});

  final String name;
  final int score;
  final int level;

  Player copyWith({String? name, int? score, int? level}) => Player(
    name: name ?? this.name,
    score: score ?? this.score,
    level: level ?? this.level,
  );

  void displayState() {
    print('---------------');
    print('''
      Player: ${name},
      Score: ${score},
      Level: ${level}
    ''');
  }
}

void main(List<String> args) {
  // Initial player
  var player = Player(name: 'Jozek', score: 0, level: 1);
  player.displayState();

  // Increase score
  player = player.copyWith(score: 10);
  player.displayState();

  // Increase level
  player = player.copyWith(level: 2);
  player.displayState();

  // Change player name
  player = player.copyWith(name: 'Carlos');
  player.displayState();
}
