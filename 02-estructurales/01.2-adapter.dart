/**
 * ! Patrón Adapter
 *  Permite que objetos con interfaces incompatibles trabajen juntos, también es muy
 *  util para utilizar librerías de terceros en nuestra aplicación sin depender
 *  directamente de ellas.
 *
 * * Es útil cuando se quiere reutilizar una clase que no tiene la interfaz que
 * * necesitamos o cuando queremos crear una capa de abstracción para una librería
 * * de terceros.
 *
 * https://refactoring.guru/es/design-patterns/adapter
 */

abstract interface class PaymentProcessor {
  void processPayment(double amount);
}

class PayPalService {
  void sendPayment(double amount) {
    print('Processing payment: $amount with PayPal');
  }
}

class StripeService {
  void makeCharge(double amount) {
    print('Processing payment: $amount with Stripe');
  }
}

class MercadoPayService {
  void pay(double amount) {
    print('Processing payment: $amount with MercadoPay');
  }
}

final class PayPalAdapter implements PaymentProcessor {
  PayPalService get _service => PayPalService();

  @override
  void processPayment(double amount) {
    _service.sendPayment(amount);
  }
}

final class StripeAdapter implements PaymentProcessor {
  StripeService get _service => StripeService();

  @override
  void processPayment(double amount) {
    _service.makeCharge(amount);
  }
}

final class MercadoPayAdapter implements PaymentProcessor {
  MercadoPayService get _service => MercadoPayService();

  @override
  void processPayment(double amount) {
    _service.pay(amount);
  }
}

void main(List<String> args) {
  const paymentAmount = 100.0;

  PaymentProcessor payPalProcessor = PayPalAdapter();
  PaymentProcessor stripeProcessor = StripeAdapter();
  PaymentProcessor mercadoPayProcessor = MercadoPayAdapter();

  print('Using PayPal:');
  payPalProcessor.processPayment(paymentAmount);

  print('Using Stripe:');
  stripeProcessor.processPayment(paymentAmount);

  print('Using MercadoPay:');
  mercadoPayProcessor.processPayment(paymentAmount);
}
