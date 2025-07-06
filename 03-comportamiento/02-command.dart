/**
 * ! Patrón Command
 * Este patrón encapsula una solicitud como un objeto,
 * lo que le permite parametrizar otros objetos con diferentes solicitudes,
 * encolar solicitudes, o registrar solicitudes, y soporta operaciones que pueden deshacerse.
 *
 * Me gustó mucho la explicación de Refactoring Guru
 * https://refactoring.guru/es/design-patterns/command
 *
 * * Es útil cuando se necesita desacoplar el objeto que invoca
 * * la operación del objeto que sabe cómo realizarla.
 *
 *
 */

final class Light {
  void turnOn() {
    print('Light is on');
  }

  void turnOff() {
    print('Light is off');
  }
}

final class Fan {
  void on() {
    print('Fan is on');
  }

  void off() {
    print('Fan is off');
  }
}

abstract interface class Command {
  void execute();
}

final class LightOnCommand implements Command {
  LightOnCommand({required Light light}) : _light = light;

  final Light _light;

  @override
  void execute() {
    _light.turnOn();
  }
}

final class LightOffCommand implements Command {
  LightOffCommand({required Light light}) : _light = light;

  final Light _light;

  @override
  void execute() {
    _light.turnOff();
  }
}

final class FanOnCommand implements Command {
  FanOnCommand({required Fan fan}) : _fan = fan;

  final Fan _fan;

  @override
  void execute() {
    _fan.on();
  }
}

final class FanOffCommand implements Command {
  FanOffCommand({required Fan fan}) : _fan = fan;

  final Fan _fan;

  @override
  void execute() {
    _fan.off();
  }
}

enum RemoteControlButtons { one, two, three, four }

final class RemoteControl {
  Map<RemoteControlButtons, Command> _commands = {};

  void setCommand({
    required RemoteControlButtons button,
    required Command command,
  }) {
    _commands[button] = command;
  }

  void pressButton(RemoteControlButtons button) {
    if (_commands.containsKey(button)) {
      _commands[button]!.execute();
      return;
    }
    print('Button not assigned');
  }
}

void main(List<String> args) {
  final remoteControl = RemoteControl();

  final light = Light();
  final lightOnCommand = LightOnCommand(light: light);
  final lightOffCommand = LightOffCommand(light: light);

  final fan = Fan();
  final fanOnCommand = FanOnCommand(fan: fan);
  final fanOffCommand = FanOffCommand(fan: fan);

  // Assign actions and commands
  remoteControl.setCommand(
    button: RemoteControlButtons.one,
    command: lightOnCommand,
  );
  remoteControl.setCommand(
    button: RemoteControlButtons.two,
    command: lightOffCommand,
  );
  remoteControl.setCommand(
    button: RemoteControlButtons.three,
    command: fanOnCommand,
  );
  remoteControl.setCommand(
    button: RemoteControlButtons.four,
    command: fanOffCommand,
  );

  // Press buttons
  remoteControl.pressButton(RemoteControlButtons.one);
  remoteControl.pressButton(RemoteControlButtons.three);
  remoteControl.pressButton(RemoteControlButtons.four);
}
