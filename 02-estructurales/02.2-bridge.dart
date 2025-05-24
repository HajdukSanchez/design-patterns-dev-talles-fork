/**
 * ! Patrón Bridge
 * Este patrón nos permite desacoplar una abstracción de su implementación,
 * de tal forma que ambas puedan variar independientemente.
 *
 * * Es útil cuando se tienen múltiples implementaciones de una abstracción
 * * Se puede utilizar para separar la lógica de negocio de la lógica de presentación
 * * Se puede utilizar para separar la lógica de la interfaz de usuario también.
 *
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
  Notification({required NotificationChannel channel}) : _channel = channel;

  NotificationChannel _channel;
  NotificationChannel get channel => _channel;

  void notify(String message);
  void setChannel(NotificationChannel channel) {
    _channel = channel;
  }
}

final class AlertNotification extends Notification {
  AlertNotification({required super.channel});

  @override
  void notify(String message) {
    print('\nAlter Notifications:');
    channel.send(message);
  }
}

final class ReminderNotification extends Notification {
  ReminderNotification({required super.channel});

  @override
  void notify(String message) {
    print('\nReminder Notifications:');
    channel.send(message);
  }
}

final class PushNotification extends Notification {
  PushNotification({required super.channel});

  @override
  void notify(String message) {
    print('\nPush Notifications:');
    channel.send(message);
  }
}

void main(List<String> args) {
  final alert = AlertNotification(channel: EmailChannel());
  alert.notify('Security alter: Unauthorized access');
  alert.setChannel(SMSChannel());
  alert.notify('Security alter: Unauthorized access');

  final reminder = ReminderNotification(channel: SMSChannel());
  reminder.notify('Reminder: You medical appointment is tomorrow');
  reminder.setChannel(PushNotificationChannel());
  reminder.notify('Reminder: You medical appointment is tomorrow');

  final push = PushNotification(channel: PushNotificationChannel());
  push.notify('New update available. Click to install');
}
