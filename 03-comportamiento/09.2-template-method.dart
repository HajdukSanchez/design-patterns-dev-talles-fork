/**
 * ! Patrón Template Method
 *
 * El patrón Template Method es un patrón de diseño de comportamiento
 * que define el esqueleto de un algoritmo en una operación,
 * delegando algunos pasos a las subclases.
 *
 * Permite que las subclases redefinan ciertos pasos de un algoritmo
 * sin cambiar su estructura.
 *
 * * Es útil cuando se tiene un algoritmo que sigue una secuencia de pasos
 * * y se quiere permitir a las subclases que redefinan algunos de esos pasos.
 *
 * https://refactoring.guru/es/design-patterns/template-method
 */

/**
 * !Objetivo: 
 * Implementar el patrón Template Method para simular un sistema de limpieza 
 * de diferentes tipos de habitaciones 
 * (por ejemplo, una habitación de hotel y una sala de conferencias). 
 * 
 * Debes diseñar una clase base que defina el flujo general de limpieza 
 * y subclases que implementen pasos específicos dependiendo del tipo 
 * de habitación.
 * 
 * 
 * 
 * ! Descripción del Ejercicio
  El proceso de limpieza general incluye los siguientes pasos:
    1.	Entrar a la habitación: Abrir la puerta y entrar.
    2.	Recoger basura: Eliminar la basura de los botes.
    3.	Limpieza específica: Depende del tipo de habitación:
    •	En una habitación de hotel, se hacen las camas.
    •	En una sala de conferencias, se limpian las mesas y se organizan las sillas.
    • En una oficina, se limpian los escritorios y se organizan los documentos.
    4.	Desinfectar superficies: Desinfectar las áreas principales.
    5.	Salir de la habitación: Cerrar la puerta y marcar como terminada
 */

abstract base class RoomCleaning {
  void cleanRoom() {
    _enterRoom();
    _collectTrash();
    specificCleaning();
    _disinfectSurfaces();
    _exitRoom();

    print(' Cleaning finished');
  }

  void _enterRoom() {
    print(' Entering to the room...');
  }

  void _collectTrash() {
    print(' Colleting trash...');
  }

  void _disinfectSurfaces() {
    print(' Desinfected surface...');
  }

  void _exitRoom() {
    print(' Exiting the room and marked as cleaned.');
  }

  void specificCleaning();
}

final class HotelRoomCleaning extends RoomCleaning {
  @override
  void specificCleaning() {
    print(' Doing beds and refilling items of bathroom');
  }
}

final class ConferenceRoomCleaning extends RoomCleaning {
  @override
  void specificCleaning() {
    print(' Cleaning tables and organizing chairs');
  }
}

final class OfficeCleaning extends RoomCleaning {
  @override
  void specificCleaning() {
    print(' Cleaning desks and organizing documents');
  }
}

void main(List<String> args) {
  print('Cleaning hotel room:');
  final hotelRoom = HotelRoomCleaning();
  hotelRoom.cleanRoom();

  print('\nCleaning conference room:');
  final conferenceRoom = ConferenceRoomCleaning();
  conferenceRoom.cleanRoom();

  print('\nCleaning office:');
  final office = OfficeCleaning();
  office.cleanRoom();
}
