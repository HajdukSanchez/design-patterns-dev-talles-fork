/**
 * ! Patrón Strategy
 *
 * El patrón Strategy es un patrón de diseño de software que define una
 * familia de algoritmos, los encapsula y los hace intercambiables.
 *
 *
 * * Es útil cuando se tiene una clase que tiene un comportamiento que puede
 * * cambiar en tiempo de ejecución y se quiere delegar la responsabilidad de
 * * la implementación a otra clase.
 *
 * https://refactoring.guru/es/design-patterns/strategy
 */

/**
 * !Objetivo: 
 * Implementar el patrón Strategy para calcular los impuestos de diferentes países.
 * 
 * !Descripción del Ejercicio

  Imagina que trabajas en una plataforma de comercio electrónico que opera en varios países. 
  Cada país tiene su propio método para calcular impuestos, 
  y necesitas implementar un sistema que sea:

    1. Flexible: Permita agregar nuevos cálculos de impuestos 
       sin modificar la lógica existente.
    2. Dinámico: Cambie la estrategia de cálculo de impuestos en tiempo 
       de ejecución según el país seleccionado.
 */

import 'dart:math';

/**	
    1.	Implementar una interfaz TaxStrategy que defina un método 
        calculateTax(amount: number): number.
        
    2.	Crear clases específicas de estrategia para los países disponibles:
      •	USA: Impuesto del 10%.
      •	Canada: Impuesto del 13%.
      •	Germany: Impuesto del 19%.
      
    3.	Implementar una clase TaxCalculator que utilice las estrategias 
        para calcular los impuestos.
 */

abstract interface class TaxStrategy {
  double calculateTax(double amount);
}

final class USATaxStrategy implements TaxStrategy {
  @override
  double calculateTax(double amount) {
    return amount * 0.1;
  }
}

final class CanadaTaxStrategy implements TaxStrategy {
  @override
  double calculateTax(double amount) {
    return amount * 0.13;
  }
}

class GermanyTaxStrategy implements TaxStrategy {
  @override
  double calculateTax(double amount) {
    return amount * 0.19;
  }
}

final class TaxCalculator {
  TaxCalculator({required TaxStrategy strategy}) : _strategy = strategy;

  TaxStrategy _strategy;

  void setStrategy(TaxStrategy strategy) {
    _strategy = strategy;
  }

  double calculate(double amount) {
    return _strategy.calculateTax(amount);
  }
}

void main(List<String> args) {
  final taxCalculator = TaxCalculator(strategy: USATaxStrategy());

  print('Tax calculator:');
  print('USA: ${taxCalculator.calculate(randomNumber()).toStringAsFixed(2)}');

  print('Change strategy to Canada...');
  taxCalculator.setStrategy(new CanadaTaxStrategy());
  print(
    'Canada: ${taxCalculator.calculate(randomNumber()).toStringAsFixed(2)}',
  );

  print('Change strategy to Germany...');
  taxCalculator.setStrategy(new GermanyTaxStrategy());
  print(
    'Germany: ${taxCalculator.calculate(randomNumber()).toStringAsFixed(2)}',
  );
}

double randomNumber() {
  return Random().nextDouble() * 100;
}
