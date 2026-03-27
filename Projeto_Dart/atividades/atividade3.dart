import 'dart:io';

void main() {
  stdout.write('Digite um número inteiro: ');
  int n = int.parse(stdin.readLineSync()!);

  print('Antecessor: ${n - 1}');
  print('Sucessor: ${n + 1}');
}