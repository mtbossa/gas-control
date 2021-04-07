import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gas_mvc/app/controllers/home_controller.dart';

main() {
  final TextEditingController newIntValueTextController =
      TextEditingController();
  final TextEditingController newDecimalValueTextController =
      TextEditingController();
  final MoneyMaskedTextController gasPriceTextController =
      MoneyMaskedTextController();

  final homeController = HomeController(
    newIntValueTextController: newIntValueTextController,
    newDecimalValueTextController: newDecimalValueTextController,
    gasPriceTextController: gasPriceTextController,
  );

  test("deve calcular os valores", () {
    newIntValueTextController.text = "5";
    newDecimalValueTextController.text = "0";
    gasPriceTextController.text = "6.99";
    homeController.calculate();
  });
}
