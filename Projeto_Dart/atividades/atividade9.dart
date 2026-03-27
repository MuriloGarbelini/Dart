import 'dart:io';

void main() {
  stdout.write('Digite a 1ª nota: ');
  double n1 = double.parse(stdin.readLineSync()!);

  stdout.write('Digite a 2ª nota: ');
  double n2 = double.parse(stdin.readLineSync()!);

  stdout.write('Digite a 3ª nota: ');
  double n3 = double.parse(stdin.readLineSync()!);

  double media = (n1 + n2 + n3) / 3;
  print('Média das notas: ${media.toStringAsFixed(2)}');
}