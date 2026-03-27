import 'dart:io';

void main() {
  stdout.write('Digite uma palavra: ');
  final texto = (stdin.readLineSync() ?? '').trim().toLowerCase();

  if (texto.isEmpty) {
    print('Entrada vazia.');
    return;
  }

  final invertido = texto.split('').reversed.join();

  if (texto == invertido) {
    print('"$texto" e um palindromo.');
  } else {
    print('"$texto" nao e um palindromo.');
  }
}
