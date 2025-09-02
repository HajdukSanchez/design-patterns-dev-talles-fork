/**
 * !Patrón Memento
 * Permite capturar y externalizar un estado interno de un objeto,
 * de manera que el objeto pueda ser restaurado a ese estado más tarde.
 *
 * * Es útil cuando se necesita guardar el estado de un objeto para poder
 * * volver a él en un futuro.
 *
 * https://refactoring.guru/es/design-patterns/memento
 */

class DrawingMemento {
  DrawingMemento({required this.shapes});

  final List<String> shapes;
}

class DrawingBoard {
  List<String> _shapes = [];

  void addShape(String shape) {
    _shapes.add(shape);
    print('Shape added: $shape');
  }

  void showBoard() {
    print('Current board: ${_shapes.join(', ')}');
  }

  DrawingMemento save() {
    return DrawingMemento(shapes: _shapes);
  }

  void restore(DrawingMemento memento) {
    _shapes = memento.shapes;
    print('Board restored...');
  }
}

class BoardHistory {
  final List<DrawingMemento> _mementos = [];

  void push(DrawingMemento memento) {
    _mementos.add(memento);
  }

  DrawingMemento? pop() {
    return _mementos.removeLast();
  }
}

void main(List<String> args) {
  final drawingBoard = DrawingBoard();
  final history = BoardHistory();

  // User add shapes and save state on each step
  drawingBoard.addShape('Circle');
  history.push(drawingBoard.save());

  drawingBoard.addShape('Square');
  history.push(drawingBoard.save());

  drawingBoard.addShape('Triangle');
  drawingBoard.showBoard();

  // Undo last step
  final lastShape = history.pop();
  if (lastShape != null) {
    drawingBoard.restore(lastShape);
    drawingBoard.showBoard();
  }

  // Undo the other one
  final lastShape2 = history.pop();
  if (lastShape2 != null) {
    drawingBoard.restore(lastShape2);
    drawingBoard.showBoard();
  }
}
