/**
 * !Patrón Visitor
 *
 * El patrón Visitor es un patrón de diseño de comportamiento
 * que te permite separar algoritmos de los objetos sobre
 * los que operan.
 *
 * * Es útil cuando necesitas añadir nuevas operaciones a
 * * clases estables sin cambiar su código.
 *
 * https://refactoring.guru/es/design-patterns/visitor
 */

/**
 * !Objetivo:
 * Implementar el patrón Visitor en un sistema de gestión de vehículos
 * que permite realizar operaciones específicas sobre diferentes
 * tipos de vehículos (automóviles, motocicletas y camiones).
 *
 * Estas operaciones incluyen calcular el costo de mantenimiento
 * y verificar si los vehículos cumplen con las normas de emisión.
 */

abstract interface class Vehicle {
  void accept(Visitor visitor);
}

final class Car implements Vehicle {
  Car({required this.year, required this.kilometers});

  final int kilometers;
  final int year;

  @override
  void accept(Visitor visitor) {
    visitor.visitCar(this);
  }
}

final class Motorcycle implements Vehicle {
  Motorcycle({required this.year, required this.kilometers});

  final int kilometers;
  final int year;

  @override
  void accept(Visitor visitor) {
    visitor.visitMotorcycle(this);
  }
}

final class Truck implements Vehicle {
  Truck({
    required this.loadCapacity,
    required this.year,
    required this.kilometers,
  });

  final int loadCapacity;
  final int kilometers;
  final int year;

  @override
  void accept(Visitor visitor) {
    visitor.visitTruck(this);
  }
}

abstract interface class Visitor {
  void visitCar(Car car);

  void visitMotorcycle(Motorcycle motorcycle);

  void visitTruck(Truck truck);
}

final class MaintenanceCostVisitor implements Visitor {
  @override
  void visitCar(Car car) {
    final cost = ((car.kilometers * 0.1) + (2024 - car.year)) * 50;

    print('Car maintenance cost: \$${cost.toStringAsFixed(2)}');
  }

  @override
  void visitMotorcycle(Motorcycle motorcycle) {
    final cost =
        ((motorcycle.kilometers * 0.05) + (2024 - motorcycle.year)) * 30;

    print('Motorcycle maintenance cost: \$${cost.toStringAsFixed(2)}');
  }

  @override
  void visitTruck(Truck truck) {
    final cost =
        (((truck.kilometers * 0.15) + (truck.loadCapacity * 20)) +
            (2024 - truck.year) * 100);

    print('Truck maintenance cost: \$${cost.toStringAsFixed(2)}');
  }
}

final class EmissionCheckVisitor implements Visitor {
  @override
  void visitCar(Car car) {
    final passes = car.year > 2000 && car.kilometers < 200_000;
    print('Car emission checked: ${passes ? 'Yes' : 'No'}');
  }

  @override
  void visitMotorcycle(Motorcycle motorcycle) {
    final passes = motorcycle.year > 2005 && motorcycle.kilometers < 100_000;
    print('Motorcycle emission checked: ${passes ? 'Yes' : 'No'}');
  }

  @override
  void visitTruck(Truck truck) {
    final passes = truck.year > 2010 && truck.kilometers < 300_000;
    print('Truck emission checked: ${passes ? 'Yes' : 'No'}');
  }
}

void main(List<String> args) {
  final vehicles = [
    Car(year: 2018, kilometers: 50_000),
    Motorcycle(year: 2015, kilometers: 30_000),
    Truck(year: 2012, kilometers: 250_000, loadCapacity: 20),
  ];

  print('\Calculating maintenance costs:');
  final maintenanceVisitor = MaintenanceCostVisitor();
  vehicles.forEach((vehicle) => vehicle.accept(maintenanceVisitor));

  print('\nChecking emissions:');
  final emissionVisitor = EmissionCheckVisitor();
  vehicles.forEach((vehicle) => vehicle.accept(emissionVisitor));
}
