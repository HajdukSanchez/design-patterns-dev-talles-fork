/**
 * ! Patrón mediator
 * Es un patrón de diseño de comportamiento que ayuda a reducir
 * las dependencias desordenadas entre objetos.
 * Este patrón limita la comunicación directa entre ellos,
 * haciendo que solo interactúen a través de un objeto mediador.
 *
 * * Es útil reducir la complejidad de las relaciones entre objetos
 *
 * https://refactoring.guru/es/design-patterns/mediator
 */

// Mediator - ControlTower
final class ControlTower {
  List<Airplane> airplanes = [];

  void registerAirplane(Airplane airplane) {
    airplanes.add(airplane);
  }

  void sendMessage({required Airplane sender, required String message}) {
    final airplanesToSend = airplanes.where((item) => item != sender);
    for (var airplane in airplanesToSend) {
      airplane.receiveMessage(sender, message);
    }
  }

  void requestLanding({required Airplane sender}) {
    print('[Control Tower]: Landing permission granted ${sender.id}');

    this.sendMessage(sender: sender, message: '${sender.id} is landing.');
  }

  void requestTakeoff({required Airplane sender}) {
    print('[Control Tower]: Take off granted ${sender.id}');

    this.sendMessage(sender: sender, message: '${sender.id} Is taking off.');
  }
}

class Airplane {
  Airplane({required this.id, required this.controlTower});

  final String id;
  final ControlTower controlTower;

  void requestLanding() {
    print('[${this.id}] request permission to land.');
    controlTower.requestLanding(sender: this);
  }

  void requestTakeoff() {
    print('[${this.id}] request permission to take off.');
    controlTower.requestTakeoff(sender: this);
  }

  void receiveMessage(Airplane sender, String message) {
    print('[${this.id}] receive message from %c${sender.id}: "${message}"');
  }
}

void main(List<String> args) {
  final controlTower = ControlTower();

  final airplane1 = Airplane(id: 'Flight 101', controlTower: controlTower);
  final airplane2 = Airplane(id: 'Flight 202', controlTower: controlTower);
  final airplane3 = Airplane(id: 'Flight 303', controlTower: controlTower);

  airplane1.requestLanding();
  airplane2.requestTakeoff();
  airplane3.requestLanding();
}
