/**
 * ! Patrón Composite
 * Es un patrón de diseño estructural que permite componer objetos
 * en estructuras de árbol para representar jerarquías.
 *
 * El patrón permite a los clientes tratar de manera uniforme a los objetos
 * individuales y a sus composiciones.
 *
 * * Es útil cuando necesitas tratar a los objetos individuales
 * * y a sus composiciones de manera uniforme, y la estructura
 * * de los objetos forma una jerarquía en árbol.
 *
 * https://refactoring.guru/es/design-patterns/composite
 *
 */
abstract interface class FileSystemComponent {
  void showDetails({String indent = ''});
}

final class File implements FileSystemComponent {
  File({required String name}) : _name = name;

  final String _name;

  @override
  void showDetails({String indent = ''}) {
    print('$indent- File: $_name');
  }
}

final class Folder implements FileSystemComponent {
  Folder({required String name}) : _name = name;

  final String _name;
  final List<FileSystemComponent> _contents = [];

  @override
  void showDetails({String indent = ''}) {
    print('$indent+ Folder: $_name/');
    _contents.forEach((content) => content.showDetails(indent: '$indent  '));
  }

  void addComponent(FileSystemComponent component) {
    _contents.add(component);
  }
}

void main(List<String> args) {
  final files = List.generate(4, (i) => File(name: 'File ${i + 1}.text'));
  final folder = Folder(name: 'Folder 1');
  folder.addComponent(files[0]);
  folder.addComponent(files[1]);

  final folder2 = Folder(name: 'Folder 2');
  folder2.addComponent(files[2]);

  final folder3 = Folder(name: 'Folder 3');
  folder3.addComponent(files[3]);
  folder3.addComponent(folder2);
  folder3.addComponent(folder);

  final rootFolder = Folder(name: 'Root');
  rootFolder.addComponent(folder);
  rootFolder.addComponent(folder2);
  rootFolder.addComponent(folder3);

  rootFolder.showDetails();
}
