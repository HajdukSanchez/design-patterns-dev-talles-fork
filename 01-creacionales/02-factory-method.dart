/**
 * ! Factory Method:
 * El patrón Factory Method permite crear objetos sin especificar
 * la clase exacta del objeto que se creará.
 *
 * En lugar de eso, delegamos la creación de objetos a subclases o métodos
 * que encapsulan esta lógica.
 *
 * * Es útil cuando una clase no puede anticipar la clase
 * * de objetos que debe crear.
 *
 * https://refactoring.guru/es/design-patterns/factory-method
 *
 */
abstract interface class Hamburger {
  void prepare();
}

final class ChickenHamburger implements Hamburger {
  @override
  void prepare() {
    print('Cooking Chicken hamburger');
  }
}

final class BeefHamburger implements Hamburger {
  @override
  void prepare() {
    print('Cooking Beef hamburger');
  }
}

final class BeanHamburger implements Hamburger {
  @override
  void prepare() {
    print('Cooking Bean hamburger');
  }
}

abstract class Restaurant {
  Hamburger createHamburger();

  void orderHamburger() {
    final hamburger = createHamburger();
    hamburger.prepare();
  }
}

class ChickenRestaurant extends Restaurant {
  @override
  Hamburger createHamburger() {
    return ChickenHamburger();
  }
}

class BeefRestaurant extends Restaurant {
  @override
  Hamburger createHamburger() {
    return BeefHamburger();
  }
}

class BeanRestaurant extends Restaurant {
  @override
  Hamburger createHamburger() {
    return BeanHamburger();
  }
}

enum BurgerType { chicken, beef, bean }

void main(List<String> args) {
  final BurgerType burgerType = BurgerType.bean;

  final Restaurant restaurant = switch (burgerType) {
    BurgerType.beef => BeefRestaurant(),
    BurgerType.chicken => ChickenRestaurant(),
    BurgerType.bean => BeanRestaurant(),
  };
  restaurant.orderHamburger();
}
