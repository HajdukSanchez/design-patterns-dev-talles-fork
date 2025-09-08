/**
 * ! Patrón State
 * Este patrón permite a un objeto cambiar su comportamiento
 * cuando su estado interno cambia.
 *
 * * Es útil cuando un objeto tiene un comportamiento que depende de su estado
 * * y debe cambiar su comportamiento en tiempo de ejecución dependiendo de ese estado.
 */

/**
 * !Objetivo:
 * Implementar el patrón State para simular el funcionamiento de una puerta
 * automática.
 *
 * La puerta tiene diferentes estados:
 *  - Cerrada
 *  - Abriéndose
 *  - Abierta
 *  - Cerrándose
 * Su comportamiento varía dependiendo del estado actual.
 */

enum DoorState { closed, opening, open, closing }

abstract interface class State {
  late DoorState name;

  void open();
  void close();
}

final class AutomaticDoor {
  AutomaticDoor() {
    _state = DoorClosed(door: this);
  }

  late State _state;

  void setState(State state) {
    _state = state;
    print('State changing to: [${state.name}]');
  }

  void open() {
    _state.open();
  }

  void close() {
    _state.close();
  }
}

final class DoorClosed implements State {
  DoorClosed({required AutomaticDoor door}) : _door = door;

  final AutomaticDoor _door;

  @override
  DoorState name = DoorState.closed;

  @override
  void close() {
    print('[$name] Door is already closed');
  }

  @override
  void open() {
    print('[$name] Opening door...');
    _door.setState(DoorOpening(door: _door));
  }
}

final class DoorOpening implements State {
  DoorOpening({required AutomaticDoor door}) : _door = door {
    _afterOpen();
  }

  final AutomaticDoor _door;

  @override
  DoorState name = DoorState.opening;

  @override
  void close() {
    print('[$name] Door cannot be closed while opening');
  }

  @override
  void open() {
    print('[$name] Door is being opened...');
  }

  Future<void> _afterOpen() async {
    await Future.delayed(Duration(seconds: 1));

    print('[$name] Door opened');
    _door.setState(DoorOpen(door: _door));
  }
}

final class DoorOpen implements State {
  DoorOpen({required AutomaticDoor door}) : _door = door;

  final AutomaticDoor _door;

  @override
  DoorState name = DoorState.open;

  @override
  void close() {
    print('[$name] Closing door');
    _door.setState(DoorClosing(door: _door));
  }

  @override
  void open() {
    print('[$name] Door is already open');
  }
}

final class DoorClosing implements State {
  DoorClosing({required AutomaticDoor door}) : _door = door;

  final AutomaticDoor _door;

  @override
  DoorState name = DoorState.closing;

  @override
  void close() {
    print('[$name] Door closed');
    _door.setState(DoorClosed(door: _door));
  }

  @override
  void open() {
    print('[$name] Detecting movement. Opening the door again');
    _door.setState(DoorOpening(door: _door));
  }
}

Future<void> main(List<String> args) async {
  final door = AutomaticDoor();

  door.close();
  door.open();
  door.close();
  door.open();
  door.close();
  door.open();
  door.close();
  door.open();
  door.close();

  await Future.delayed(Duration(seconds: 1));
  door.open();
  door.close();
}
