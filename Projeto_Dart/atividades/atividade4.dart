import 'dart:io';

void main() {
  double salarioMinimo = 1412.0;

  stdout.write('Digite o salário do usuário: ');
  double salarioUsuario = double.parse(stdin.readLineSync()!);

  double qtdSalariosMinimos = salarioUsuario / salarioMinimo;

  print('Esse usuário ganha ${qtdSalariosMinimos.toStringAsFixed(2)} salários mínimos.');
}
