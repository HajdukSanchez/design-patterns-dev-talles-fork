/**
 * ! Patrón Facade
 * Este patrón proporciona una interfaz unificada para un conjunto de interfaces
 * en un subsistema.
 *
 * Facade define una interfaz de nivel más alto que hace que el subsistema
 * sea más fácil de usar.
 *
 * * Es útil cuando un subsistema es complejo o difícil de entender para
 * * proporcionar una interfaz simplificada para el cliente.
 *
 * https://refactoring.guru/es/design-patterns/facade
 */

// !Tarea: Tarea: Sistema de Encendido de una Computadora con el Patrón Facade

final class CPU {
  void stopOperations() {
    print('CPU: Stooping operations.');
  }

  void jump(int position) {
    print("CPU: Jumping to memory position ${position}.");
  }

  void execute() {
    print('CPU: Executing instructions.');
  }
}

final class HardDrive {
  String read(int position, int size) {
    print("HardDrive: Reading ${size} bytes from position ${position}.");
    return '001010001010100';
  }

  void close() {
    print('HardDrive: stooping hard drive.');
  }
}

final class Memory {
  void load(int position, String data) {
    print("Memory: Loading data from position ${position} ${data}.");
  }

  void free() {
    print('Memory: freeing memory space.');
  }
}

final class ComputerFacade {
  ComputerFacade({
    required CPU cpu,
    required HardDrive hardDrive,
    required Memory memory,
  }) : _cpu = cpu,
       _hardDrive = hardDrive,
       _memory = memory;

  final CPU _cpu;
  final HardDrive _hardDrive;
  final Memory _memory;

  void startComputer() {
    print('Starting computer...');

    _memory.load(0, _hardDrive.read(0, 1024));
    _cpu.jump(0);
    _cpu.execute();

    print('Computer ready to be used.');
  }

  void shutDownComputer() {
    print('Shuting down computer...');
    print('Closing process and saving data...');

    _cpu.stopOperations();
    _memory.free();
    _hardDrive.close();

    print('Computer closed.');
  }
}

void main(List<String> args) {
  final computer = ComputerFacade(
    cpu: CPU(),
    hardDrive: HardDrive(),
    memory: Memory(),
  );

  computer.startComputer();
  print('...');
  computer.shutDownComputer();
}
