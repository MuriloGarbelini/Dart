import 'dart:io';

void main() {
  stdout.write('Digite um número: ');
  int n = int.parse(stdin.readLineSync()!);

  if (n % 2 == 0) {
    print('O número é par.');
  } else {
    print('O número é ímpar.');
  }

  if (n > 0) {
    print('O número é positivo.');
  } else if (n < 0) {
    print('O número é negativo.');
  } else {
    print('O número é zero.');
  }
}