import 'dart:io';

void main() {
  stdout.write('Digite a temperatura em Celsius: ');
  final celsius = double.parse(stdin.readLineSync()!.replaceAll(',', '.'));

  final fahrenheit = (celsius * 9 / 5) + 32;
  print('${celsius.toStringAsFixed(2)} C = ${fahrenheit.toStringAsFixed(2)} F');
}
