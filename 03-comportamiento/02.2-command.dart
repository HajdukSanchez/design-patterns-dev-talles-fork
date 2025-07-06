/**
 * ! Patrón Command
 * Este patrón encapsula una solicitud como un objeto,
 * lo que le permite parametrizar otros objetos con diferentes solicitudes,
 * encolar solicitudes, o registrar solicitudes, y soporta operaciones que pueden deshacerse.
 *
 * Me gustó mucho la explicación de Refactoring Guru
 * https://refactoring.guru/es/design-patterns/command
 *
 * * Es útil cuando se necesita desacoplar el objeto que invoca
 * * la operación del objeto que sabe cómo realizarla.
 *
 */

final class TextEditor {
  String _text = '';
  String _clipboard = '';
  List<String> _history = [];

  void type(String text) {
    _history.add(text);
    _text += text;
  }

  void copy() {
    _clipboard = _text;
    print('Text copied in the clipboard: ${_clipboard}');
  }

  void paste() {
    _history.add(_text);
    _text += _clipboard;
    print('Text after paste: ${_text}');
  }

  void undo() {
    if (_history.length > 0) {
      _text = _history.removeLast();
      print('Text after undo: ${_text}');
      return;
    }

    print('Nothing to undo');
  }

  String getText() => _text;
}

abstract interface class Command {
  void execute();
}

final class CopyCommand implements Command {
  CopyCommand({required TextEditor editor}) : _editor = editor;

  final TextEditor _editor;

  @override
  void execute() {
    _editor.copy();
  }
}

final class PasteCommand implements Command {
  PasteCommand({required TextEditor editor}) : _editor = editor;

  final TextEditor _editor;

  @override
  void execute() {
    _editor.paste();
  }
}

final class UndoCommand implements Command {
  UndoCommand({required TextEditor editor}) : _editor = editor;

  final TextEditor _editor;

  @override
  void execute() {
    _editor.undo();
  }
}

final class Toolbar {
  Map<String, Command> _commands = {};

  void setCommand({required String button, required Command command}) {
    _commands[button] = command;
  }

  void clickButton(String button) {
    if (_commands.containsKey(button)) {
      _commands[button]!.execute();
      return;
    }

    print('No command assigned to the button "${button}"');
  }
}

void main(List<String> args) {
  final editor = TextEditor();
  final toolbar = Toolbar();

  final copyCommand = CopyCommand(editor: editor);
  final pasteCommand = PasteCommand(editor: editor);
  final undoCommand = UndoCommand(editor: editor);

  toolbar.setCommand(button: 'copy', command: copyCommand);
  toolbar.setCommand(button: 'paste', command: pasteCommand);
  toolbar.setCommand(button: 'undo', command: undoCommand);
  toolbar.setCommand(button: 'undo2', command: undoCommand);

  editor.type('H');
  editor.type('o');
  editor.type('l');
  editor.type('a');
  editor.type(' ');
  editor.type('M');
  editor.type('u');
  editor.type('n');
  editor.type('d');
  editor.type('o');
  editor.type('!');
  print('Actual text: "${editor.getText()}"');

  print('\nCopying text:');
  toolbar.clickButton('copy');

  print('\nPasting text:');
  toolbar.clickButton('paste');

  print('\nUndo last action:');
  toolbar.clickButton('undo');

  print('\nRemoving action');
  toolbar.clickButton('undo2');

  print('\nFinal text: "${editor.getText()}"');
}
