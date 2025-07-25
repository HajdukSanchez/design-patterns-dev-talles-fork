/**
 * ! Patrón mediator
 * Es un patrón de diseño de comportamiento que ayuda a reducir
 * las dependencias desordenadas entre objetos.
 * Este patrón limita la comunicación directa entre ellos,
 * haciendo que solo interactúen a través de un objeto mediador.
 *
 * * Es útil reducir la complejidad de las relaciones entre objetos
 *
 * https://refactoring.guru/es/design-patterns/mediator
 */

final class User {
  User({required this.userName});

  final String userName;

  void receiveMessage({required User sender, required String message}) {
    print('[$userName] message received from ${sender.userName}: "$message"');
  }
}

// This is the mediator
final class ChatRoom {
  ChatRoom({required this.title});

  final String title;
  List<User> _users = [];

  void addUser(User user) {
    _users.add(user);
  }

  void addAllUsers(List<User> users) {
    _users.addAll(users);
  }

  void sendMessage({required User sender, required String message}) {
    print('[${sender.userName}] message sent: "$message"');
    final usersToSend = _users.where((user) => user != sender).toList();

    for (var user in usersToSend) {
      user.receiveMessage(sender: sender, message: message);
    }
    print('\n');
  }
}

void main(List<String> args) {
  final chatRoom = ChatRoom(title: 'Work group');
  final users = List.generate(
    3,
    (index) => User(userName: 'User ${index + 1}'),
  );
  chatRoom.addAllUsers(users);

  chatRoom.sendMessage(sender: users[0], message: 'Hello all');
  chatRoom.sendMessage(sender: users[1], message: 'Hello 1');
  chatRoom.sendMessage(sender: users[2], message: 'Hello 1 and 2');
}
