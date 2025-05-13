/**
 * ! Patrón Prototype:

 * Es un patrón de diseño creacional que nos permite copiar objetos existentes sin hacer
 * que el código dependa de sus clases.
 * 
 * * Es útil cuando queremos duplicar el contenido, 
 * * el título y el autor de un documento, por ejemplo o cualquier objeto complejo.
 * 
 * https://refactoring.guru/es/design-patterns/prototype
 */

class Document {
  final String title;
  final String _content;
  final String author;

  Document({
    required String title,
    required String content,
    required String author,
  }) : title = title,
       _content = content,
       author = author;

  Document clone() => Document(title: title, content: _content, author: author);

  void displayInfo() {
    print('Title: $title \nContent: $_content \nAuthor: $author');
  }
}

void main(List<String> args) {
  final document = Document(
    title: 'New Document',
    content: 'New Content',
    author: 'New Author',
  );

  document.displayInfo();
  final doc2 = document.clone();
  doc2.displayInfo();
}
