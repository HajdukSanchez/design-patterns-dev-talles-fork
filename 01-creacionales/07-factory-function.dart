/**
 * ! Factory Function
 * Es un patrón de diseño que nos permite crear objetos o funciones de manera dinámica que serán
 * usados posteriormente en el código.
 *
 * * Es útil cuando necesitamos crear objetos o funciones de manera dinámica,
 * * es decir, en tiempo de ejecución y no en tiempo de compilación.
 *
 */

enum Language { es, en, fr }

typedef GreeterFunction = String Function(String name);

GreeterFunction createGreeter({required Language language}) {
  return (String name) {
    final message = switch (language) {
      Language.en => 'Hello $name',
      Language.es => 'Hola $name',
      Language.fr => 'Bonjour $name',
    };
    return message;
  };
}

void main(List<String> args) {
  final spanishGreeter = createGreeter(language: Language.es);
  final message = spanishGreeter('Jozek');
  print(message);

  final message2 = spanishGreeter('Juan');
  print(message2);

  final message3 = spanishGreeter('Ana');
  print(message3);
}
