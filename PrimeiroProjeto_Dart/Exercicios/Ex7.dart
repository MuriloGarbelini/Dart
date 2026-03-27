import 'dart:io';

void main() {
  stdout.write('Digite o numero da tabuada: ');
  final n = int.parse(stdin.readLineSync()!);

  print('Tabuada do $n:');
  for (var i = 1; i <= 10; i++) {
    print('$n x $i = ${n * i}');
  }
}
