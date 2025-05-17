/**
 * ! Abstract Factory:
 * Es un patrón de diseño que permite crear familias de objetos relacionados
 * sin especificar sus clases concretas.
 *
 * En lugar de crear objetos individuales directamente,
 * creamos fábricas que producen un conjunto de objetos relacionados.
 *
 * * Es útil cuando necesitas crear objetos que son parte de una familia
 * * y quieres asegurarte de que estos objetos se complementen entre sí.
 *
 * https://refactoring.guru/es/design-patterns/abstract-factory
 */

/**
 *  El propósito del Abstract Factory es crear familias de objetos relacionados
 *  (en este caso, hamburguesas y bebidas) sin especificar las clases concretas
 *  de cada uno de esos objetos en el código principal.
 */
abstract interface class Hamburger {
  void prepare();
}

abstract interface class Drink {
  void pour();
}

class BeanHamburger implements Hamburger {
  @override
  void prepare() {
    print('Preparing Bean Burger');
  }
}

class BeefHamburger implements Hamburger {
  @override
  void prepare() {
    print('Preparing Beef Burger');
  }
}

class Water implements Drink {
  @override
  void pour() {
    print('Preparing glass of water');
  }
}

class Soda implements Drink {
  @override
  void pour() {
    print('Preparing glass of soda');
  }
}

abstract interface class MenuFactory {
  Hamburger createHamburger();
  Drink createDrink();
}

class FastFoodMenuFactory implements MenuFactory {
  @override
  Drink createDrink() {
    return Soda();
  }

  @override
  Hamburger createHamburger() {
    return BeefHamburger();
  }
}

class HealthyMenuFactory implements MenuFactory {
  @override
  Drink createDrink() {
    return Water();
  }

  @override
  Hamburger createHamburger() {
    return BeanHamburger();
  }
}

enum MenuKind { fastFoodMenu, healthyMenu }

void main(List<String> args) {
  MenuFactory createMenu(MenuKind menu) {
    return switch (menu) {
      MenuKind.fastFoodMenu => FastFoodMenuFactory(),
      MenuKind.healthyMenu => HealthyMenuFactory(),
    };
  }

  void createCombo1(MenuFactory menu) {
    final hamburger = menu.createHamburger();
    final drink = menu.createDrink();

    hamburger.prepare();
    drink.pour();
  }

  void startProcess() {
    for (var menu in MenuKind.values) {
      final foodMenu = createMenu(menu);
      print('Menu [${foodMenu.runtimeType}]:');
      print('Creating Combo 1....');
      createCombo1(foodMenu);
      print('--------------------');
    }
  }

  startProcess();
}
