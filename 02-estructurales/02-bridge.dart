/**
 * ! Patrón Bridge
 * Este patrón nos permite desacoplar una abstracción de su implementación,
 * de tal forma que ambas puedan variar independientemente.
 *
 * * Es útil cuando se tienen múltiples implementaciones de una abstracción
 * * Se puede utilizar para separar la lógica de negocio de la lógica de presentación
 * * Se puede utilizar para separar la lógica de la interfaz de usuario también.
 *
 * https://refactoring.guru/es/design-patterns/bridge
 */

// Code block called 'Implementation' in the pattern
abstract interface class Ability {
  void use();
}

class SwordAttack implements Ability {
  @override
  void use() {
    print('Attack with a sword');
  }
}

class MagicAttack implements Ability {
  @override
  void use() {
    print('Attack with a magic power');
  }
}

class MagicFireballAttack implements Ability {
  @override
  void use() {
    print('Attack with a magic fire ball');
  }
}

class AxeAttack implements Ability {
  @override
  void use() {
    print('Attack with an axe');
  }
}

// Code block called 'Abstraction' in the pattern
abstract class Character {
  Character({required Ability ability}) : _ability = ability;

  Ability _ability;

  Ability get ability => _ability;

  void updateAbility(Ability ability) {
    _ability = ability;
  }

  void performAbility();
}

class Warrior extends Character {
  Warrior({required super.ability});

  @override
  void performAbility() {
    print('\nWarrior attack:');
    this.ability.use();
  }
}

class Magician extends Character {
  Magician({required super.ability});

  @override
  void performAbility() {
    print('\nMagician attack:');
    this.ability.use();
  }
}

void main(List<String> args) {
  final warrior = Warrior(ability: SwordAttack());
  warrior.performAbility();
  warrior.updateAbility(AxeAttack());
  warrior.performAbility();

  final magician = Magician(ability: MagicAttack());
  magician.performAbility();
  warrior.updateAbility(MagicFireballAttack());
  magician.performAbility();
}
