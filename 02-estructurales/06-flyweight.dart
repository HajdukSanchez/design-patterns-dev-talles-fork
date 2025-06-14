/**
 * ! Patrón Flyweight
 * Es un patrón de diseño estructural que nos permite usar objetos compartidos
 * para soportar eficientemente grandes cantidades de objetos.
 *
 * * Es útil cuando necesitamos una gran cantidad de objetos y queremos reducir
 * * la cantidad de memoria que utilizan.
 *
 * https://refactoring.guru/es/design-patterns/flyweight
 */

enum LocationsType { school, hospital, park }

class Coordinates {
  Coordinates({required this.x, required this.y});

  final int x;
  final int y;
}

// Flyweight
final class LocationIcon {
  LocationIcon({required LocationsType type, required String iconImage})
    : _type = type,
      _iconImage = iconImage;

  final LocationsType _type;
  final String _iconImage;

  void display({required Coordinates coordinates}) {
    print(
      'Coords: ${_type.name} in (${coordinates.x}, ${coordinates.y}), with icon [ $_iconImage ]',
    );
  }
}

// Flyweight's factory
final class LocationIconsFactory {
  final Map<LocationsType, LocationIcon> icons = {};

  LocationIcon getLocationIcon(LocationsType type) {
    if (icons.containsKey(type)) {
      return icons[type]!;
    }

    final iconImage = 'image_of_${type.name}.png';
    print('...Creating new icon in memory: [ $iconImage ]');
    final locationIcon = LocationIcon(type: type, iconImage: iconImage);
    icons[type] = locationIcon;
    return locationIcon;
  }
}

final class MapLocation {
  MapLocation({
    required Coordinates coordinates,
    required LocationIcon locationIcon,
  }) : _coordinates = coordinates,
       _locationIcon = locationIcon;

  final Coordinates _coordinates;
  final LocationIcon _locationIcon;

  void display() {
    _locationIcon.display(coordinates: _coordinates);
  }
}

void main(List<String> args) {
  final factory = LocationIconsFactory();
  final locations = [
    MapLocation(
      coordinates: Coordinates(x: 10, y: 20),
      locationIcon: factory.getLocationIcon(LocationsType.hospital),
    ),
    MapLocation(
      coordinates: Coordinates(x: 20, y: 45),
      locationIcon: factory.getLocationIcon(LocationsType.hospital),
    ),
    MapLocation(
      coordinates: Coordinates(x: 20, y: 66),
      locationIcon: factory.getLocationIcon(LocationsType.hospital),
    ),
    MapLocation(
      coordinates: Coordinates(x: 20, y: 661),
      locationIcon: factory.getLocationIcon(LocationsType.school),
    ),
    MapLocation(
      coordinates: Coordinates(x: 10, y: 661),
      locationIcon: factory.getLocationIcon(LocationsType.park),
    ),
    MapLocation(
      coordinates: Coordinates(x: 10, y: 63),
      locationIcon: factory.getLocationIcon(LocationsType.school),
    ),
  ];

  locations.forEach((location) => location.display());
}
