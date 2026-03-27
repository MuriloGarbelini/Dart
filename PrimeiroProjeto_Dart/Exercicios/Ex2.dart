import 'dart:io';

void main() {
  stdout.write('Digite um numero inteiro nao negativo: ');
  final n = int.parse(stdin.readLineSync()!);

  if (n < 0) {
    print('Nao existe fatorial de numero negativo.');
    return;
  }

  var resultado = BigInt.one;
  for (var i = 2; i <= n; i++) {
    resultado *= BigInt.from(i);
  }

  print('$n! = $resultado');
}
