/**
 * ! Patrón State
 * Este patrón permite a un objeto cambiar su comportamiento
 * cuando su estado interno cambia.
 *
 * * Es útil cuando un objeto tiene un comportamiento que depende de su estado
 * * y debe cambiar su comportamiento en tiempo de ejecución dependiendo de ese estado.
 *
 * https://refactoring.guru/es/design-patterns/state
 */

/**
 * * Objetivo: Implementar el patrón State para simular el funcionamiento
 * * de una máquina expendedora.
 * * La máquina tiene diferentes estados,
 *  * Como Esperando Dinero,
 *  * Seleccionando Producto,
 *  * Entregando Producto,
 * * y su comportamiento varía dependiendo del estado actual.
 */
abstract interface class MachineState {
  late final String name;

  void insertMoney();

  void selectProduct();

  void dispenseProduct();
}

final class VendingMachine {
  VendingMachine() {
    _state = WaitingForMoneyState(machine: this);
  }

  late MachineState _state;

  void insertMoney() {
    _state.insertMoney();
  }

  void selectProduct() {
    _state.selectProduct();
  }

  void dispenseProduct() {
    _state.dispenseProduct();
  }

  void setState(MachineState state) {
    _state = state;
    print('State changes: ${_state.name}');
  }
}

final class WaitingForMoneyState implements MachineState {
  WaitingForMoneyState({required VendingMachine machine}) : _machine = machine;

  final VendingMachine _machine;

  @override
  String name = 'Waiting for money';

  @override
  void dispenseProduct() {
    print('[$name]: First you need to insert money');
  }

  @override
  void insertMoney() {
    print('[$name]: Money inserted. Now you can select a product');
    _machine.setState(ProductSelectedState(machine: _machine));
  }

  @override
  void selectProduct() {
    print('[$name]: First you need to insert money');
  }
}

final class ProductSelectedState implements MachineState {
  ProductSelectedState({required VendingMachine machine}) : _machine = machine;

  final VendingMachine _machine;

  @override
  String name = 'Product selected';

  @override
  void dispenseProduct() {
    print('[$name]: First you need to select product');
  }

  @override
  void insertMoney() {
    print('[$name]: Please select a product, you already inserted money');
  }

  @override
  void selectProduct() {
    print('[$name]: Product selected');
    _machine.setState(DispensingProductState(machine: _machine));
  }
}

final class DispensingProductState implements MachineState {
  DispensingProductState({required VendingMachine machine})
    : _machine = machine;

  final VendingMachine _machine;

  @override
  String name = 'Dispensing product';

  @override
  void dispenseProduct() {
    print('[$name]: Product dispensed');
    _machine.setState(WaitingForMoneyState(machine: _machine));
  }

  @override
  void insertMoney() {
    print(
      '[$name]: Please wait for your product to be dispensed, you already inserted money',
    );
  }

  @override
  void selectProduct() {
    print(
      '[$name]: Please wait for your product to be dispensed, you already selected product',
    );
  }
}

void main(List<String> args) {
  final vendingMachine = VendingMachine();

  // Try to select a product
  vendingMachine.selectProduct();
  // Try to get a product
  vendingMachine.dispenseProduct();

  // Insert money
  vendingMachine.insertMoney();
  // Select a product
  vendingMachine.selectProduct();
  // Get a product
  vendingMachine.dispenseProduct();
}
