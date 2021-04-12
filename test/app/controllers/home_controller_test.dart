import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  final TextEditingController newIntValueTextController =
      TextEditingController();
  final TextEditingController newDecimalValueTextController =
      TextEditingController();
  final MoneyMaskedTextController gasPriceTextController =
      MoneyMaskedTextController();

  test("deve calcular os valores", () {
    newIntValueTextController.text = "5";
    newDecimalValueTextController.text = "0";
    gasPriceTextController.text = "6.99";
  });
}
