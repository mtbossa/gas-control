import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gas_mvc/app/models/gas_model.dart';

class HomeController {
  final List<Leitura> listLeituras;
  final TextEditingController newIntValueTextController;
  final TextEditingController newDecimalValueTextController;
  final MoneyMaskedTextController gasPriceTextController;

  HomeController({
    @required this.listLeituras, 
    @required this.newIntValueTextController,
    @required this.newDecimalValueTextController,
    @required this.gasPriceTextController,
  });

  void calculate() {
  }
}
