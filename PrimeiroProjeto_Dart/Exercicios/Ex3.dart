import 'dart:io';

void main() {
  stdout.write('Digite um numero inteiro: ');
  final n = int.parse(stdin.readLineSync()!);

  if (n < 2) {
    print('$n nao e primo.');
    return;
  }

  var primo = true;
  for (var i = 2; i * i <= n; i++) {
    if (n % i == 0) {
      primo = false;
      break;
    }
  }

  if (primo) {
    print('$n e primo.');
  } else {
    print('$n nao e primo.');
  }
}
