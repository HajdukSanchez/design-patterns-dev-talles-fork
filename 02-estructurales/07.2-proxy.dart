/**
 * ! Patrón Proxy
 * Este patrón se utiliza para controlar el acceso a un objeto, es decir,
 * se crea un objeto que actúa como intermediario entre el cliente y el objeto real.
 *
 * * Es útil cuando necesitamos controlar el acceso a un objeto,
 * * por ejemplo, para verificar si el cliente tiene permiso
 * * para acceder a ciertos métodos o propiedades.
 *
 * https://refactoring.guru/es/design-patterns/proxy
 *
 */

enum UserRol { admin, user }

final class User {
  User({required this.name, required this.rol});

  final String name;
  final UserRol rol;
}

abstract interface class Document {
  void displayContent(User user);
}

final class ConfidentialDocument implements Document {
  ConfidentialDocument({required String content}) : _content = content;

  final String _content;

  @override
  void displayContent(User user) {
    print('Document content: \n${_content}\n');
  }
}

final class DocumentProxy implements Document {
  DocumentProxy({required Document document}) : _document = document;

  final Document _document;

  bool mustHaveRole(UserRol rol) => switch (rol) {
    UserRol.admin => true,
    UserRol.user => false,
  };

  @override
  void displayContent(User user) {
    if (mustHaveRole(user.rol)) {
      _document.displayContent(user);
      return;
    }

    print(
      'Denied access. ${user.name}, you dont have access to see the document',
    );
  }
}

void main(List<String> args) {
  final confidentialDoc = ConfidentialDocument(
    content: 'This is the content of the confidential document',
  );
  final proxy = DocumentProxy(document: confidentialDoc);

  final user1 = User(name: 'Juan', rol: UserRol.admin);
  final user2 = User(name: 'Juan D', rol: UserRol.user);

  print('Trying access for user 1:');
  proxy.displayContent(user1);

  print('Trying access for user 2:');
  proxy.displayContent(user2);
}
