/**
 * ! Patrón Composite
 * Es un patrón de diseño estructural que permite componer objetos
 * en estructuras de árbol para representar jerarquías.
 *
 * El patrón permite a los clientes tratar de manera uniforme a los objetos
 * individuales y a sus composiciones.
 *
 * * Es útil cuando necesitas tratar a los objetos individuales
 * * y a sus composiciones de manera uniforme, y la estructura
 * * de los objetos forma una jerarquía en árbol.
 *
 * https://refactoring.guru/es/design-patterns/composite
 *
 */

abstract interface class MenuComponent {
  String get name;
  void showDetails({String indent = ''});
}

abstract interface class MenuComponentComposite implements MenuComponent {
  List<MenuComponent> get items;
  void add(MenuComponent item);
  void addAll(List<MenuComponent> items);
}

final class MenuItem implements MenuComponent {
  MenuItem({required String name, required double price})
    : _name = name,
      _price = price;

  final String _name;
  final double _price;

  @override
  void showDetails({String indent = ''}) {
    print('$indent- $_name: ${_price.toStringAsFixed(2)}');
  }

  @override
  String get name => _name;
}

final class MenuCategory implements MenuComponentComposite {
  MenuCategory({required String name}) : _name = name;

  final String _name;
  final List<MenuComponent> _items = [];

  @override
  void showDetails({String indent = ''}) {
    print('$indent+ $_name');
    items.forEach((i) => i.showDetails(indent: '$indent '));
  }

  @override
  String get name => _name;

  @override
  List<MenuComponent> get items => _items;

  @override
  void add(MenuComponent item) {
    _items.add(item);
  }

  @override
  void addAll(List<MenuComponent> items) {
    _items.addAll(items);
  }
}

void main(List<String> args) {
  final salad = MenuItem(name: 'Salad', price: 5.99);
  final soup = MenuItem(name: 'Tomato soup', price: 4.99);
  final steak = MenuItem(name: 'Mea', price: 15.99);
  final soda = MenuItem(name: 'Soda', price: 2.5);
  final dessert = MenuItem(name: 'Chocolate cake', price: 6.5);
  final coffee = MenuItem(name: 'Coffee', price: 1.99);

  final appetizers = MenuCategory(name: 'Entrances');
  appetizers.add(salad);
  appetizers.add(soup);

  final mainCourse = MenuCategory(name: 'Main dish');
  mainCourse.add(steak);

  final beverages = MenuCategory(name: 'Drinks');
  beverages.add(soda);
  beverages.add(coffee);

  final desserts = MenuCategory(name: 'Desserts');
  desserts.add(dessert);

  final mainMenu = MenuCategory(name: 'Main menu');
  mainMenu.addAll([appetizers, beverages, desserts, mainCourse]);
  mainMenu.add(mainCourse);
  mainMenu.add(beverages);
  mainMenu.add(desserts);

  print('Restaurant menu');
  mainMenu.showDetails();
}
