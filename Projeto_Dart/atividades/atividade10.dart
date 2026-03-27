import 'dart:io';

void main() {
  stdout.write('Digite o nome do aluno: ');
  String nome = stdin.readLineSync()!;

  stdout.write('Digite a 1ª nota: ');
  double n1 = double.parse(stdin.readLineSync()!);

  stdout.write('Digite a 2ª nota: ');
  double n2 = double.parse(stdin.readLineSync()!);

  stdout.write('Digite a 3ª nota: ');
  double n3 = double.parse(stdin.readLineSync()!);

  stdout.write('Digite a 4ª nota: ');
  double n4 = double.parse(stdin.readLineSync()!);

  double media = (n1 + n2 + n3 + n4) / 4;
  String situacao = media >= 7 ? 'Aprovado' : 'Reprovado';

  print('\nAluno: $nome');
  print('Média final: ${media.toStringAsFixed(2)}');
  print('Situação: $situacao');
}