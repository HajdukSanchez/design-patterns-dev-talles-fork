/**
 * ! Patrón Builder:
 * Es un patrón de diseño creacional que nos permite construir objetos complejos
 * paso a paso.
 *
 * El patrón nos permite producir distintos tipos y representaciones
 * de un objeto empleando el mismo código de construcción.
 *
 * * Es útil cuando necesitamos construir un objeto complejo con muchas partes
 * * y queremos que el proceso de construcción sea independiente de las partes
 * * que lo componen.
 *
 * https://refactoring.guru/es/design-patterns/builder
 */
class Computer {
  String cpu = 'Undefined';
  String ram = 'Undefined';
  String storage = 'Undefined';
  String? gpu = 'Undefined';

  void displayConfiguration() {
    final data =
        'PC config: CPU = ${cpu}, RAM = ${ram}, STORAGE = ${storage}, GPU = ${gpu}';
    print(data);
  }
}

class ComputerBuilder {
  ComputerBuilder() {
    _computer = Computer();
  }

  late final Computer _computer;

  ComputerBuilder setCPU(String cpu) {
    _computer.cpu = cpu;
    return this;
  }

  ComputerBuilder setRAM(String ram) {
    _computer.ram = ram;
    return this;
  }

  ComputerBuilder setStorage(String storage) {
    _computer.storage = storage;
    return this;
  }

  ComputerBuilder setGPU(String gpu) {
    _computer.gpu = gpu;
    return this;
  }

  Computer build() {
    return this._computer;
  }
}

void main() {
  final basicComputer =
      ComputerBuilder().setCPU('M2').setRAM('4gb').setStorage('256 gb').build();
  basicComputer.displayConfiguration();

  final gamingComputer =
      ComputerBuilder()
          .setCPU('M2')
          .setCPU('M4')
          .setRAM('4gb')
          .setStorage('256 gb')
          .setGPU('16gb')
          .build();
  gamingComputer.displayConfiguration();
}
