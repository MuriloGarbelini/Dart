import 'dart:io';

void main(List<String> args) {
  print("Valor A:");
  int a = int.parse(stdin.readLineSync()!);

  print("Valor B:");
  int b = int.parse(stdin.readLineSync()!);

  int soma = a + b;

  print("Soma é: $soma");
}
