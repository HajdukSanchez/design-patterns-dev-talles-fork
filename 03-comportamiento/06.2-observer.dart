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
  void update(String weatherData);
}

final class WeatherStation {
  final List<Observer> _observers = [];
  String _weatherData = 'Sunny';

  void subscribe(Observer observer) {
    _observers.add(observer);

    print('New application subscribe to weather system (${_observers.length})');
  }

  void unsubscribe(Observer observer) {
    _observers.remove(observer);

    print(
      'New application unsubscribe to weather system (${_observers.length})',
    );
  }

  void setWeather(String weatherData) {
    print('Weather updated: $weatherData');
    this._weatherData = weatherData;
    _notifyObservers();
  }

  void _notifyObservers() {
    _observers.forEach((_observer) {
      _observer.update(this._weatherData);
    });
  }
}

final class WeatherApp implements Observer {
  WeatherApp({required this.name});

  final String name;

  @override
  void update(String weatherData) {
    print('[$name] - New notification: New weather data: $weatherData');
  }
}

void main(List<String> args) {
  final weatherStation = WeatherStation();

  // Create apps
  final flutterWeatherApp = WeatherApp(name: 'Flutter WeatherApp');
  final reactNativeWeatherApp = WeatherApp(name: 'React Native WeatherApp');
  final weatherTrackerApp = WeatherApp(name: 'Weather Tracker App');

  // Subscribe apps
  weatherStation
    ..subscribe(flutterWeatherApp)
    ..subscribe(reactNativeWeatherApp);

  // Update weather
  weatherStation.setWeather('Raining');

  // Add new app
  weatherStation.subscribe(weatherTrackerApp);
  weatherStation.setWeather('Cloudy');

  // Unsubscribe apps
  weatherStation.unsubscribe(reactNativeWeatherApp);
  weatherStation.setWeather('Electric storm');
}
