import 'dart:core';

String validarTamanho(String numero) {
  if (numero.length >= 12 && numero.length <= 19) {
    return numero;
  } else {
    return "";
  }
}

String validarBandeira(String numero) {
  if (RegExp(r'^4').hasMatch(numero)) {
    return 'Visa';
  } else if (RegExp(
    r'^(5[1-5]|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)',
  ).hasMatch(numero)) {
    return 'Mastercard';
  } else if (RegExp(r'^3[47]').hasMatch(numero)) {
    return 'American Express';
  } else if (RegExp(r'^(6011|65|64[4-9]|622)').hasMatch(numero)) {
    return 'Discover';
  } else if (RegExp(r'^(30[0-5]|36|38|39)').hasMatch(numero)) {
    return 'Diners Club';
  } else if (RegExp(r'^35(2[89]|[3-8][0-9]|9[0-9])').hasMatch(numero)) {
    return 'JCB';
  } else if (RegExp(r'^636').hasMatch(numero)) {
    return 'Elo';
  } else {
    return 'Desconhecida';
  }
}

bool validarLuhn(String numero) {
  int soma = 0;
  bool dobrar = false;

  for (int i = numero.length - 1; i >= 0; i--) {
    int digito = int.parse(numero[i]);

    if (dobrar) {
      digito *= 2;
      if (digito > 9) {
        digito = (digito % 10) + 1;
      }
    }

    soma += digito;
    dobrar = !dobrar;
  }

  return soma % 10 == 0;
}
