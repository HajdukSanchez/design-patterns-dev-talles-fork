/**
 * ! Patrón Facade
 * Este patrón proporciona una interfaz unificada para un conjunto de interfaces
 * en un subsistema.
 *
 * Facade define una interfaz de nivel más alto que hace que el subsistema
 * sea más fácil de usar.
 *
 * * Es útil cuando un subsistema es complejo o difícil de entender para
 * * proporcionar una interfaz simplificada para el cliente.
 *
 * https://refactoring.guru/es/design-patterns/facade
 */

final class Projector {
  void turnOn() {
    print('Projector on');
  }

  void turnOff() {
    print('Projector off');
  }
}

final class SoundSystem {
  void on() {
    print('Sound system on');
  }

  void off() {
    print('Sound system off');
  }
}

final class VideoPlayer {
  void on() {
    print('Video player on');
  }

  void play(String movie) {
    print('Playing movie: ' + movie);
  }

  void stop() {
    print('Video player stopped');
  }

  void off() {
    print('Video player off');
  }
}

final class PopCornMaker {
  void poopingPopCorn() {
    print('Pooping pop corn');
  }

  void stopPoopingPopCorn() {
    print('Stop pooping pop corn');
  }
}

final class HomeTheaterFacade {
  HomeTheaterFacade({
    required Projector projector,
    required SoundSystem soundSystem,
    required VideoPlayer videoPlayer,
    required PopCornMaker popCornMaker,
  }) : _projector = projector,
       _soundSystem = soundSystem,
       _videoPlayer = videoPlayer,
       _popCornMaker = popCornMaker;

  final Projector _projector;
  final SoundSystem _soundSystem;
  final VideoPlayer _videoPlayer;
  final PopCornMaker _popCornMaker;

  void watchMovie(String movie) {
    print('Starting to watch movie...');
    _projector.turnOn();
    _soundSystem.on();
    _popCornMaker.poopingPopCorn();
    _videoPlayer.on();
    _videoPlayer.play(movie);
  }

  void endMovie() {
    print('Ending movie...');
    _projector.turnOff();
    _soundSystem.off();
    _popCornMaker.stopPoopingPopCorn();
    _videoPlayer.stop();
    _videoPlayer.off();
  }
}

void main(List<String> args) {
  final homeTheater = HomeTheaterFacade(
    projector: Projector(),
    soundSystem: SoundSystem(),
    videoPlayer: VideoPlayer(),
    popCornMaker: PopCornMaker(),
  );

  homeTheater.watchMovie('Avengers');
  print('.....');
  homeTheater.endMovie();
}
