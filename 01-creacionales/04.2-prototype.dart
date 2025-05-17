/**
 * ! Patrón Prototype:

 * Es un patrón de diseño creacional que nos permite copiar objetos existentes sin hacer
 * que el código dependa de sus clases.
 * 
 * * Es útil cuando queremos duplicar el contenido, 
 * * el título y el autor de un documento, por ejemplo o cualquier objeto complejo.
 * 
 * https://refactoring.guru/es/design-patterns/prototype
 */

class Pokemon {
  final String name;
  final String type;
  final int level;
  final List<String> attacks;

  Pokemon({
    required this.name,
    required this.type,
    required this.level,
    required this.attacks,
  });

  Pokemon clone() {
    return Pokemon(name: name, type: type, level: level, attacks: attacks);
  }

  void displayInfo() {
    print('Pokemon:');
    print(
      '''Name: ${this.name}\nType: ${this.type}\nLevel: ${this.level}\nAttacks: ${this.attacks.join(', ')}''',
    );
    print('---------------');
  }
}

void main(List<String> args) {
  final basePokemon = Pokemon(
    name: 'Picachu',
    type: 'Fire',
    level: 10,
    attacks: ['Lick'],
  );
  final pokemon2 = basePokemon.clone();

  basePokemon.displayInfo();
  pokemon2.displayInfo();
}
