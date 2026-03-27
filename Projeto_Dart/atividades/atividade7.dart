import 'dart:io';

void main() {
  stdout.write('Digite o 1º inteiro: ');
  int a = int.parse(stdin.readLineSync()!);

  stdout.write('Digite o 2º inteiro: ');
  int b = int.parse(stdin.readLineSync()!);

  stdout.write('Digite o 3º inteiro: ');
  int c = int.parse(stdin.readLineSync()!);

  List<int> nums = [a, b, c];
  nums.sort((x, y) => y.compareTo(x)); // decrescente

  print('Ordem decrescente: ${nums.join(', ')}');
}