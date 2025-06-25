/**
 * ! Patron Chain of Responsibility
 * Es un patrón de diseño de comportamiento que te permite pasar solicitudes
 * a lo largo de una cadena de manejadores.
 *
 * * Es útil cuando se necesita procesar datos de diferentes maneras, pero no
 * * se sabe de antemano qué tipo de procesamiento se necesita o en qué orden
 * * pero se sabe que se necesita procesar en una secuencia.
 */

abstract interface class Approver {
  Approver setNext(Approver approver);
  void approveRequest(int amount);
}

abstract class BaseApprover implements Approver {
  Approver? _nextApprover;

  Approver setNext(Approver approver) {
    _nextApprover = approver;
    return approver;
  }

  void approveRequest(int amount);

  void next(int amount) {
    if (_nextApprover != null) {
      _nextApprover!.approveRequest(amount);
      return;
    }

    print("Request can't be approved");
  }
}

final class Supervisor extends BaseApprover {
  @override
  void approveRequest(int amount) {
    if (amount <= 1000) {
      print('Request approved by Supervisor');
      return;
    }
    next(amount);
  }
}

final class Manager extends BaseApprover {
  @override
  void approveRequest(int amount) {
    if (amount <= 5000) {
      print('Request approved by Manager');
      return;
    }

    next(amount);
  }
}

final class Director extends BaseApprover {
  @override
  void approveRequest(int amount) {
    print('Request approved by Director');
  }
}

void main(List<String> args) {
  final supervisor = Supervisor();
  final manager = Manager();
  final director = Director();

  supervisor.setNext(manager).setNext(director);

  print('New request 500:');
  supervisor.approveRequest(500);

  print('New request 3000:');
  supervisor.approveRequest(3000);

  print('New request 7000:');
  supervisor.approveRequest(7000);
}
