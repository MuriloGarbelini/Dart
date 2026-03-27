import 'dart:io';

bool lerBool(String msg) {
  stdout.write(msg);
  String v = stdin.readLineSync()!.trim().toLowerCase();
  return v == 'true' || v == '1' || v == 'sim' || v == 's';
}

void main() {
  bool a = lerBool('Digite o 1º valor lógico (true/false): ');
  bool b = lerBool('Digite o 2º valor lógico (true/false): ');

  if (a && b) {
    print('Ambos são VERDADEIROS');
  } else {
    print('Ambos são FALSOS? ${!a && !b ? "SIM" : "NÃO"}');
  }
}