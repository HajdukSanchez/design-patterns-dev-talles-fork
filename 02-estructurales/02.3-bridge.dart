/**
 * ! Patrón Bridge
 * Este patrón nos permite desacoplar una abstracción de su implementación,
 * de tal forma que ambas puedan variar independientemente.
 *
 * * Es útil cuando se tienen múltiples implementaciones de una abstracción
 * * Se puede utilizar para separar la lógica de negocio de la lógica de presentación
 * * Se puede utilizar para separar la lógica de la interfaz de usuario también.
 *
 * https://refactoring.guru/es/design-patterns/bridge
 */

abstract interface class NotificationChannel {
  void send(String message);
}

final class EmailChannel implements NotificationChannel {
  @override
  void send(String message) {
    print('[$runtimeType]: $message');
  }
}

final class SMSChannel implements NotificationChannel {
  @override
  void send(String message) {
    print('[$runtimeType]: $message');
  }
}

final class PushNotificationChannel implements NotificationChannel {
  @override
  void send(String message) {
    print('[$runtimeType]: $message');
  }
}

abstract class Notification {
  Notification({required List<NotificationChannel> channels})
    : _channels = channels;

  List<NotificationChannel> _channels;
  List<NotificationChannel> get channels => _channels;

  void notify(String message);
  void addChannel(NotificationChannel newChannel) {
    _channels.add(newChannel);
  }
}

final class AlertNotification extends Notification {
  AlertNotification({required super.channels});

  @override
  void notify(String message) {
    print('\nAlter Notifications:');
    channels.forEach((channel) => channel.send(message));
  }
}

void main(List<String> args) {
  final channels = [EmailChannel(), SMSChannel(), PushNotificationChannel()];
  final alert = AlertNotification(channels: channels);
  alert.notify('Security alter: Unauthorized access');
}
