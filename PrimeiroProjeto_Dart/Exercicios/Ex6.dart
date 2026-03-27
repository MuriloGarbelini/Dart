import 'dart:io';

void main() {
  stdout.write('Digite o peso (kg): ');
  final peso = double.parse(stdin.readLineSync()!.replaceAll(',', '.'));

  stdout.write('Digite a altura (m): ');
  final altura = double.parse(stdin.readLineSync()!.replaceAll(',', '.'));

  if (peso <= 0 || altura <= 0) {
    print('Peso e altura devem ser maiores que zero.');
    return;
  }

  final imc = peso / (altura * altura);
  print('IMC = ${imc.toStringAsFixed(2)}');
}
