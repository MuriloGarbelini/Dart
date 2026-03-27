import 'dart:io';

void main() {
  stdout.write('Digite A: ');
  double a = double.parse(stdin.readLineSync()!);

  stdout.write('Digite B: ');
  double b = double.parse(stdin.readLineSync()!);

  stdout.write('Digite C: ');
  double c = double.parse(stdin.readLineSync()!);

  double soma = a + b;

  print('Soma de A + B = $soma');
  if (soma < c) {
    print('A soma é menor que C.');
  } else {
    print('A soma NÃO é menor que C.');
  }
}