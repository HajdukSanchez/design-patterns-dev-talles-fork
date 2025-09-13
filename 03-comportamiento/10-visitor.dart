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
 * Contexto: Imagina que estás diseñando un sistema para un parque
 * temático con diferentes tipos de atracciones:
 * montañas rusas, casas del terror y ruedas de la fortuna.
 *
 * Cada atracción tiene su propio precio de entrada y ofrece un descuento
 * dependiendo del tipo de visitante (niño, adulto o adulto mayor).
 *
 * Aquí es donde entra el patrón Visitor, que permite aplicar operaciones
 * específicas (como calcular el precio con descuento) dependiendo tanto
 * de la atracción como del tipo de visitante,
 * sin modificar las clases originales.
 */

abstract interface class Attraction {
  int get price;

  void accept(ParkVisitor visitor);
}

final class RollerCoaster implements Attraction {
  @override
  void accept(ParkVisitor visitor) {
    visitor.visitRollerCoaster(this);
  }

  @override
  int get price => 50;
}

final class HauntedHouse implements Attraction {
  @override
  void accept(ParkVisitor visitor) {
    visitor.visitHauntedHouse(this);
  }

  @override
  int get price => 40;
}

final class RussianHill implements Attraction {
  @override
  void accept(ParkVisitor visitor) {
    visitor.visitRussianHill(this);
  }

  @override
  int get price => 30;
}

abstract interface class ParkVisitor {
  void visitRollerCoaster(RollerCoaster rollerCoaster);

  void visitHauntedHouse(HauntedHouse hauntedHouse);

  void visitRussianHill(RussianHill russianHill);
}

final class ChildVisitor implements ParkVisitor {
  @override
  void visitHauntedHouse(HauntedHouse hauntedHouse) {
    print(
      'Child in haunted house: Price with discount \$${hauntedHouse.price * 0.7}',
    );
  }

  @override
  void visitRollerCoaster(RollerCoaster rollerCoaster) {
    print(
      'Child in roller coaster: Price with discount \$${rollerCoaster.price * 0.5}',
    );
  }

  @override
  void visitRussianHill(RussianHill russianHill) {
    print(
      'Child in russian hill: Price with discount \$${russianHill.price * 0.6}',
    );
  }
}

final class AdultVisitor implements ParkVisitor {
  @override
  void visitHauntedHouse(HauntedHouse hauntedHouse) {
    print(
      'Adult in haunted house: Price with discount \$${hauntedHouse.price}',
    );
  }

  @override
  void visitRollerCoaster(RollerCoaster rollerCoaster) {
    print(
      'Adult in roller coaster: Price with discount \$${rollerCoaster.price}',
    );
  }

  @override
  void visitRussianHill(RussianHill russianHill) {
    print('Adult in russian hill: Price with discount \$${russianHill.price}');
  }
}

final class SeniorAdultVisitor implements ParkVisitor {
  @override
  void visitHauntedHouse(HauntedHouse hauntedHouse) {
    print(
      'Senior adult in haunted house: Price with discount \$${hauntedHouse.price * 0.85}',
    );
  }

  @override
  void visitRollerCoaster(RollerCoaster rollerCoaster) {
    print(
      'Senior adult in roller coaster: Price with discount \$${rollerCoaster.price * 0.85}',
    );
  }

  @override
  void visitRussianHill(RussianHill russianHill) {
    print(
      'Senior adult in russian hill: Price with discount \$${russianHill.price * 0.85}',
    );
  }
}

void main(List<String> args) {
  final attractions = [RollerCoaster(), HauntedHouse(), RussianHill()];
  print('Attractions prices:');
  attractions.forEach((attraction) {
    print('[${attraction.runtimeType}]: \$${attraction.price}');
  });

  print('\nChild visitor:');
  final child = ChildVisitor();
  attractions.forEach((attraction) => attraction.accept(child));

  print('\nAdult visitor:');
  final adult = AdultVisitor();
  attractions.forEach((attraction) => attraction.accept(adult));

  print('\nSenior adult visitor:');
  final senior = SeniorAdultVisitor();
  attractions.forEach((attraction) => attraction.accept(senior));
}
