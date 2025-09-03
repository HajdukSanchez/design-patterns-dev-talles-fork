/**
 * ! Patrón Observer
 * El patrón Observer es un patrón de diseño de comportamiento que establece
 * una relación de uno a muchos entre un objeto, llamado sujeto,
 * y otros objetos, llamados observadores, que son notificados
 * y actualizados automáticamente por el sujeto
 * cuando se producen cambios en su estado.
 *
 * * Es útil cuando necesitamos que varios objetos estén
 * * pendientes de los cambios
 *
 * !No confundirlo con RXJS Observables
 *
 * https://refactoring.guru/es/design-patterns/observer
 */
abstract interface class Observer {
  void notify({required String newVideoTitle});
}

final class YoutubeChannel {
  YoutubeChannel({required this.channelName});

  final String channelName;
  List<Observer> _subscribers = [];

  void subscribe(Observer observer) {
    _subscribers.add(observer);
    print(
      '[$channelName] New subscriber - Number of subscribers: ${_subscribers.length}',
    );
  }

  void unSubscribe(Observer observer) {
    _subscribers.remove(observer);
    print(
      '[$channelName] UnSubscriber  - Number of subscribers: ${_subscribers.length}',
    );
  }

  void uploadVideo({required String title}) {
    print('[$channelName] New video: $title');

    _subscribers.forEach((_subscriber) {
      _subscriber.notify(newVideoTitle: title);
    });
  }
}

final class Subscriber implements Observer {
  Subscriber({required this.name});

  final String name;

  @override
  void notify({required String newVideoTitle}) {
    print('[$name] - New Notification: New video to watch: $newVideoTitle');
  }
}

void main(List<String> args) {
  final channel1 = YoutubeChannel(channelName: 'Channel 1');
  final channel2 = YoutubeChannel(channelName: 'Channel 2');
  final users = List.generate(
    3,
    (index) => Subscriber(name: 'User ${index + 1}'),
  );

  // Subscribe 2 users
  channel1
    ..subscribe(users[0])
    ..subscribe(users[1]);
  // Subscribe 1 users
  channel2.subscribe(users[0]);

  // Upload new video
  channel1.uploadVideo(title: 'CH1 - Video 1');
  // Upload new video
  channel2.uploadVideo(title: 'CH2 - Video 1');
  // New Subscriber
  channel1.subscribe(users[2]);
  // Upload new video
  channel1.uploadVideo(title: 'CH1 - Video 2');
  // UnSubscriber
  channel1.unSubscribe(users[1]);
  // Upload new video
  channel1.uploadVideo(title: 'CH1 - Video 3');
}
