import 'dart:io';

void main() {
  stdout.write('Digite um valor: ');
  double valor = double.parse(stdin.readLineSync()!);

  double reajustado = valor * 1.05;
  print('Valor com reajuste de 5%: ${reajustado.toStringAsFixed(2)}');
}