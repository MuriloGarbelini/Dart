import 'dart:io';

void main() {
  stdout.write('Digite N: ');
  final n = int.parse(stdin.readLineSync()!);

  if (n < 1) {
    print('N deve ser maior ou igual a 1.');
    return;
  }

  var soma = 0;
  for (var i = 2; i <= n; i += 2) {
    soma += i;
  }

  print('Soma dos numeros pares de 1 ate $n = $soma');
}
