/**
 * ! Patrón Iterator
 * Este patrón permite recorrer los elementos de una colección sin exponer
 * la estructura interna de la colección.
 *
 * * Es útil cuando se necesita recorrer una colección de elementos sin importar
 * * cómo se almacenan los elementos.
 *
 * https://refactoring.guru/es/design-patterns/iterator
 */

abstract interface class Iterator<T> {
  T? next();

  bool hasNext();

  T? current();
}

final class Pokemon {
  Pokemon({required this.name, required this.type});

  final String name;
  final String type;

  @override
  String toString() => 'Pokemon: $name, Type: $type';
}

final class PokemonCollection {
  List<Pokemon> _pokemons = [];

  void addPokemon(Pokemon pokemon) {
    _pokemons.add(pokemon);
  }

  Pokemon? getPokemon({required int at}) {
    if (at <= 0 && at > _pokemons.length) {
      return null;
    }

    return _pokemons[at];
  }

  int get length => _pokemons.length;

  PokemonIterator createIterator() {
    return PokemonIterator(collection: this);
  }
}

final class PokemonIterator implements Iterator<Pokemon> {
  PokemonIterator({required PokemonCollection collection})
    : _collection = collection;

  final PokemonCollection _collection;
  int _position = 0;

  @override
  Pokemon? current() {
    return _collection.getPokemon(at: _position);
  }

  @override
  bool hasNext() {
    return _position < _collection.length;
  }

  @override
  Pokemon? next() {
    if (hasNext()) {
      return _collection.getPokemon(at: _position++);
    }
    return null;
  }
}

void main(List<String> args) {
  final pokemonCollection = PokemonCollection();
  pokemonCollection.addPokemon(Pokemon(name: 'A', type: 'A'));
  pokemonCollection.addPokemon(Pokemon(name: 'B', type: 'B'));
  pokemonCollection.addPokemon(Pokemon(name: 'C', type: 'C'));
  pokemonCollection.addPokemon(Pokemon(name: 'D', type: 'D'));
  pokemonCollection.addPokemon(Pokemon(name: 'E', type: 'E'));

  final iterator = pokemonCollection.createIterator();

  while (iterator.hasNext()) {
    final pokemon = iterator.next();
    if (pokemon != null) {
      print(pokemon.toString());
    }
  }
}
