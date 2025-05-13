/**
 * !Instrucciones:
 	1.Completen las Clases de Productos:
    •	ElectricCar debe implementar Vehicle y mostrar el mensaje "Ensamblando un auto eléctrico".
    •	GasCar debe implementar Vehicle y mostrar el mensaje "Ensamblando un auto de combustión".
    •	ElectricEngine debe implementar Engine y mostrar el mensaje "Arrancando motor eléctrico".
    •	GasEngine debe implementar Engine y mostrar el mensaje "Arrancando motor de combustión".

	2.	Completen las Clases de Fábricas:
    •	ElectricVehicleFactory debe crear un ElectricCar y un ElectricEngine.
    •	GasVehicleFactory debe crear un GasCar y un GasEngine.

	3. Prueben el Código:
	  •	Ejecuten el código para asegurarse de que cada fábrica produce el tipo correcto de vehículo y motor.
 */

abstract interface class Vehicle {
  void assemble();
}

abstract interface class Engine {
  void start();
}

class ElectricCar implements Vehicle {
  @override
  void assemble() {
    print('Assemble electric car');
  }
}

class GasCar implements Vehicle {
  @override
  void assemble() {
    print('Assemble gas car');
  }
}

class ElectricEngine implements Engine {
  @override
  void start() {
    print('Starting electric engine');
  }
}

class GasEngine implements Engine {
  @override
  void start() {
    print('Starting gas engine');
  }
}

abstract interface class VehicleFactory {
  Vehicle createVehicle();
  Engine createEngine();
}

class ElectricVehicleFactory implements VehicleFactory {
  @override
  Engine createEngine() {
    return ElectricEngine();
  }

  @override
  Vehicle createVehicle() {
    return ElectricCar();
  }
}

class GasVehicleFactory implements VehicleFactory {
  @override
  Engine createEngine() {
    return GasEngine();
  }

  @override
  Vehicle createVehicle() {
    return GasCar();
  }
}

main() {
  final vehiclesFactories = [ElectricVehicleFactory(), GasVehicleFactory()];

  for (var factory in vehiclesFactories) {
    print('Creating a new vehicle [${factory.runtimeType}]:');
    final vehicle = factory.createVehicle();
    final engine = factory.createEngine();
    vehicle.assemble();
    engine.start();
    print('-----------------------');
  }
}
