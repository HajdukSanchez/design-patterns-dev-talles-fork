/**
 * ! Patron Chain of Responsibility
 * Es un patrón de diseño de comportamiento que te permite pasar solicitudes
 * a lo largo de una cadena de manejadores.
 *
 * * Es útil cuando se necesita procesar datos de diferentes maneras, pero no
 * * se sabe de antemano qué tipo de procesamiento se necesita o en qué orden
 * * pero se sabe que se necesita procesar en una secuencia.
 *
 * https://refactoring.guru/es/design-patterns/chain-of-responsibility
 */
enum RequestType { basic, advanced, expert, other }

abstract interface class Handler {
  Handler setNext(Handler handler);
  void handle(RequestType request);
}

abstract base class BaseHandler implements Handler {
  Handler? _nextHandler;

  @override
  void handle(RequestType request) {
    if (_nextHandler != null) {
      _nextHandler!.handle(request);
    }
  }

  @override
  Handler setNext(Handler handler) {
    _nextHandler = handler;
    return handler;
  }
}

// Call center Supports
final class BasicSupport extends BaseHandler {
  @override
  void handle(RequestType request) {
    if (request == RequestType.basic) {
      print('[Basic]: support being solved: $request');
      return;
    }

    print('[Basic]: Sending request to other area');
    super.handle(request);
  }
}

final class AdvancedSupport extends BaseHandler {
  @override
  void handle(RequestType request) {
    if (request == RequestType.advanced) {
      print('[Advanced]: support being solved: $request');
      return;
    }

    print('[Advanced]: Sending request to other area');
    super.handle(request);
  }
}

final class ExpertSupport extends BaseHandler {
  @override
  void handle(RequestType request) {
    if (request == RequestType.expert) {
      print('[Expert]: Support being solved: $request');
      return;
    }

    print('[Expert]: Nothing to do ...');
  }
}

void main(List<String> args) {
  final basicSupport = BasicSupport();
  final advancedSupport = AdvancedSupport();
  final expertSupport = ExpertSupport();

  basicSupport.setNext(advancedSupport).setNext(expertSupport);

  for (var request in RequestType.values) {
    print('New request');
    basicSupport.handle(request);
    print('Request finished');
  }
}
