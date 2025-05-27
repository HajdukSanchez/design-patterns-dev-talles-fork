/**
 * ! Patrón decorador
 * Es un patrón de diseño estructural que permite añadir
 * funcionalidades a objetos, colocando estos objetos dentro de
 * objetos encapsuladores especiales que contienen estas funcionalidades.
 *
 * No confundirlo con los decoradores de TypeScript que son anotaciones.
 *
 * * Es útil cuando necesitas añadir funcionalidades a objetos
 *  * de manera dinámica y flexible.
 *
 * https://refactoring.guru/es/design-patterns/decorator
 */

final class Stats {
  Stats({required this.attack, required this.defense});

  final int attack;
  final int defense;

  Stats copyWith({int? attack, int? defense}) =>
      Stats(attack: attack ?? this.attack, defense: defense ?? this.defense);

  @override
  String toString() {
    return '{attack: $attack, defense: $defense}';
  }
}

abstract interface class Character {
  String getDescription();
  Stats getStats();
}

final class BasicCharacter implements Character {
  @override
  String getDescription() {
    return 'Basic character';
  }

  @override
  Stats getStats() {
    return Stats(attack: 10, defense: 10);
  }
}

final class SoldierCharacter implements Character {
  @override
  String getDescription() {
    return 'Soldier character';
  }

  @override
  Stats getStats() {
    return Stats(attack: 50, defense: 50);
  }
}

abstract class CharacterDecorator implements Character {
  CharacterDecorator({required Character character}) : _character = character;

  final Character _character;

  @override
  String getDescription() {
    return _character.getDescription();
  }

  @override
  Stats getStats() {
    return _character.getStats();
  }
}

final class HelmetDecorator extends CharacterDecorator {
  HelmetDecorator({required super.character});

  @override
  String getDescription() {
    return _character.getDescription() + '\n * with helmet';
  }

  @override
  Stats getStats() {
    final currentChar = _character.getStats();
    return currentChar.copyWith(defense: currentChar.defense + 5);
  }
}

final class ShieldDecorator extends CharacterDecorator {
  ShieldDecorator({required super.character});

  @override
  String getDescription() {
    return _character.getDescription() + '\n * with shield';
  }

  @override
  Stats getStats() {
    final currentChar = _character.getStats();
    return currentChar.copyWith(defense: currentChar.defense + 10);
  }
}

class SwordDecorator extends CharacterDecorator {
  SwordDecorator({required super.character});

  @override
  String getDescription() {
    return _character.getDescription() + '\n * with sword';
  }

  @override
  Stats getStats() {
    final currentChar = _character.getStats();
    return currentChar.copyWith(attack: currentChar.attack + 7);
  }
}

class RingDecorator extends CharacterDecorator {
  RingDecorator({required super.character});

  @override
  String getDescription() {
    return _character.getDescription() + '\n * with ring';
  }

  @override
  Stats getStats() {
    final currentChar = _character.getStats();
    return currentChar.copyWith(attack: currentChar.attack + 3);
  }
}

void main(List<String> args) {
  Character character = BasicCharacter();
  print('\nInitial character: ${character.getDescription()}');
  print('Stats: ${character.getStats()}');
  character = HelmetDecorator(character: character);
  print('\nWith Helmet: ${character.getDescription()}');
  print('Stats: ${character.getStats()}');
  character = ShieldDecorator(character: character);
  print('\nWith Shield: ${character.getDescription()}');
  print('Stats: ${character.getStats()}');
  character = SwordDecorator(character: character);
  print('\nWith Sword: ${character.getDescription()}');
  print('Stats: ${character.getStats()}');
  character = RingDecorator(character: character);
  print('\nWith Ring: ${character.getDescription()}');
  print('Stats: ${character.getStats()}');

  Character soldierCharacter = SoldierCharacter();
  print('\Initial character: ${soldierCharacter.getDescription()}');
  print('Stats: ${soldierCharacter.getStats()}');
  soldierCharacter = ShieldDecorator(character: soldierCharacter);
  print('\nWith Shield: ${soldierCharacter.getDescription()}');
  print('Stats: ${soldierCharacter.getStats()}');
  soldierCharacter = SwordDecorator(character: soldierCharacter);
  print('\nWith Sword: ${soldierCharacter.getDescription()}');
  print('Stats: ${soldierCharacter.getStats()}');
}
