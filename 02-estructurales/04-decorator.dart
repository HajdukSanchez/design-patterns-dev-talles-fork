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
abstract interface class Notification {
  void send({required String message});
}

final class BasicNotification implements Notification {
  @override
  void send({required String message}) {
    print('[$runtimeType] Sending basic notification: $message');
  }
}

// Decorator
abstract class NotificationDecorator implements Notification {
  NotificationDecorator({required Notification notification})
    : _notification = notification;

  final Notification _notification;
}

// Kinds of decorators
final class EmailNotificationDecorator extends NotificationDecorator {
  EmailNotificationDecorator({required super.notification});

  @override
  void send({required String message}) {
    _notification.send(message: message);
    _sendEmail(message: message);
  }

  void _sendEmail({required String message}) {
    print('[$runtimeType] Sending email notification: $message');
  }
}

final class SMSNotificationDecorator extends NotificationDecorator {
  SMSNotificationDecorator({required super.notification});

  @override
  void send({required String message}) {
    _notification.send(message: message);
    _sendSms(message: message);
  }

  void _sendSms({required String message}) {
    print('[$runtimeType] Sending sms notification: $message');
  }
}

void main(List<String> args) {
  // Notification via: Basic only
  print('Basic:');
  Notification notification = BasicNotification();
  notification.send(message: 'System alert');

  // Notification via: Basic, Email and SMS
  print('\nBasic, Email and SMS:');
  Notification notificationA = BasicNotification();
  notificationA = EmailNotificationDecorator(notification: notificationA);
  notificationA = SMSNotificationDecorator(notification: notificationA);
  notificationA.send(message: 'System alert A');

  // Notification via: Basic and Email
  print('\nBasic and Email:');
  Notification notificationB = BasicNotification();
  notificationB = EmailNotificationDecorator(notification: notificationB);
  notificationB.send(message: 'System alert B');

  // Notification via: Basic and SMS
  print('\nBasic and SMS:');
  Notification notificationC = BasicNotification();
  notificationC = SMSNotificationDecorator(notification: notificationC);
  notificationC.send(message: 'System alert C');
}
