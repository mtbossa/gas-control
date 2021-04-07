import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gas_mvc/app/controllers(unused)/home_controller.dart';
import 'package:gas_mvc/app/models/gas_model.dart';

main() {
  final TextEditingController newIntValueTextController =
      TextEditingController();
  final TextEditingController newDecimalValueTextController =
      TextEditingController();
  final MoneyMaskedTextController gasPriceTextController =
      MoneyMaskedTextController();
  List<Leitura> listLeituras = [];

  final homeController = HomeController(
    listLeituras: listLeituras,
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
