/**
 * ! Patrón Proxy
 * Este patrón se utiliza para controlar el acceso a un objeto, es decir,
 * se crea un objeto que actúa como intermediario entre el cliente y el objeto real.
 *
 * * Es útil cuando necesitamos controlar el acceso a un objeto,
 * * por ejemplo, para verificar si el cliente tiene permiso
 * * para acceder a ciertos métodos o propiedades.
 *
 * https://refactoring.guru/es/design-patterns/proxy
 *
 */

final class Player {
  Player({required this.name, required this.level});

  final String name;
  final int level;
}

abstract interface class Room {
  void enter(Player player);
}

final class SecretRoom implements Room {
  @override
  void enter(Player player) {
    print('Welcome ${player.name} to secret room');
  }
}

// Proxy class
final class MagicPortal implements Room {
  MagicPortal({required Room room}) : _room = room;

  final Room _room;

  @override
  void enter(Player player) {
    if (player.level >= 10) {
      _room.enter(player);
      return;
    }

    print('Sorry ${player.name}, your level is not enough to enter this room');
  }
}

void main(List<String> args) {
  final secretRoom = SecretRoom();
  final magicPortal = MagicPortal(room: secretRoom);

  final player1 = Player(name: 'Jozek', level: 5);
  final player2 = Player(name: 'Andrzej', level: 15);

  print('Player 1 trying to enter secret room');
  magicPortal.enter(player1);

  print('\n');
  print('Player 2 trying to enter secret room');
  magicPortal.enter(player2);
}
