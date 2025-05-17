/**
 * ! Inmutabilidad con copia
 * Aunque la inmutabilidad es una buena práctica, no siempre es posible.
 * En estos casos, se puede hacer una copia del objeto y modificar la copia.
 *
 *  * Es útil para mantener un historial de estados en aplicaciones interactivas.
 *
 */
class CodeEditorState {
  CodeEditorState({
    required this.content,
    required this.cursorLinePosition,
    required this.unsaveChanges,
  });

  final String content;
  final int cursorLinePosition;
  final bool unsaveChanges;

  CodeEditorState copyWith({
    String? content,
    int? cursorLinePosition,
    bool? unsaveChanges,
  }) => CodeEditorState(
    content: content ?? this.content,
    cursorLinePosition: cursorLinePosition ?? this.cursorLinePosition,
    unsaveChanges: unsaveChanges ?? this.unsaveChanges,
  );

  void displayState() {
    print('''
      CodeEditorState:
        - content: ${content}
        - cursor line position: ${cursorLinePosition}
        - unsave changes: ${unsaveChanges}
    ''');
  }
}

class CodeEditorHistory {
  List<CodeEditorState> _codeEditorHistory = [];
  int _currentIndex = -1;

  void save(CodeEditorState currentState) {
    if (_currentIndex < _codeEditorHistory.length - 1) {
      _codeEditorHistory = _codeEditorHistory.sublist(0, _currentIndex + 1);
    }
    _codeEditorHistory.add(currentState);
    _currentIndex++;
  }

  CodeEditorState? undo() {
    if (_currentIndex > 0) {
      _currentIndex--;
      return _codeEditorHistory[_currentIndex];
    }

    return null;
  }

  CodeEditorState? redo() {
    if (_currentIndex < _codeEditorHistory.length - 1) {
      _currentIndex++;
      return _codeEditorHistory[_currentIndex];
    }

    return null;
  }

  void showHistory() {
    for (var state in _codeEditorHistory) {
      print('------------');
      state.displayState();
    }
  }
}

void main(List<String> args) {
  final history = CodeEditorHistory();

  // Initial state
  var state = CodeEditorState(
    content: 'Initial content',
    cursorLinePosition: 2,
    unsaveChanges: false,
  );
  history.save(state);

  // Changes
  state = state.copyWith(
    content: 'New content',
    cursorLinePosition: 3,
    unsaveChanges: true,
  );
  history.save(state);

  state = state.copyWith(cursorLinePosition: 5);
  history.save(state);

  state = history.undo()!;
  state = history.redo()!;
  state = history.undo()!;

  // Show saved history
  history.showHistory();
}
