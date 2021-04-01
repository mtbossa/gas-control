import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gas_mvc/app/models/gas_model.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'input_gas_new_value.dart';
import 'input_gas_price.dart';

class ContainerValues extends StatelessWidget {
  final TextEditingController newIntValueTextController;
  final TextEditingController newDecimalValueTextController;
  final MoneyMaskedTextController gasPriceTextController;
  final List<Leitura> listLeituras;
  final _fCubicMeter = NumberFormat("####0.000", Platform.localeName);

  ContainerValues({
    Key key,
    @required this.newIntValueTextController,
    @required this.newDecimalValueTextController,
    @required this.gasPriceTextController,
    @required this.listLeituras,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Leitura atual",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              checkEmpty(),
            ],
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                  left: 8.0,
                  bottom: 8.0,
                ),
                child: Text(
                  "Nova leitura",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              InputGasValue(
                newDecimalValueTextController: newDecimalValueTextController,
                newIntValueTextController: newIntValueTextController,
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                  left: 8.0,
                  bottom: 8.0,
                ),
                child: Text(
                  "Preço kg/gás",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              InputGasPrice(
                gasPriceController: gasPriceTextController,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Text checkEmpty() {
    if (listLeituras.isEmpty ||
        listLeituras.last.cubicMeterValue == 0.0 ||
        listLeituras.last.cubicMeterValue == null) {
      return Text(
        "${_fCubicMeter.format(0.000)} m³",
        style: TextStyle(
          color: Colors.green[900],
          fontSize: 17,
        ),
      );
    } else {
      return Text(
        // Displays the most recent added gas value
        "${_fCubicMeter.format(listLeituras.last.cubicMeterValue)} m³",
        style: TextStyle(
          color: Colors.green[900],
          fontSize: 17,
        ),
      );
    }
  }
}
