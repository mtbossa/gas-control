import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gas_mvc/app/models/gas_model.dart';

class HomeController {
  TextEditingController newIntValueTextController;
  TextEditingController newDecimalValueTextController;
  MoneyMaskedTextController gasPriceTextController;

  HomeController(
      {@required this.newIntValueTextController,
      @required this.newDecimalValueTextController,
      @required this.gasPriceTextController});

  GasModel gasModel = GasModel();

  void calculateKg() {
    String newIntValueText = newIntValueTextController.text;
    String newDecimalValueText = newDecimalValueTextController.text;

    double newIntDoubleValue = double.tryParse(newIntValueText) ?? 0.0;
    /* 
     * Divided by 1000 so it becomes 0,###, to be the
     * total value decimals
     */
    double newDecimalDoubleValue =
        ((double.tryParse(newDecimalValueText) ?? 0.0) / 1000);
    /*
     * The total value of the newValue. Ex.: 12,456 (m³)
     */
    double newTotalValue = newIntDoubleValue + newDecimalDoubleValue;

    double returnValueKg;
  }
}
