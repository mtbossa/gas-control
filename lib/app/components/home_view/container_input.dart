import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gas_mvc/app/models/leitura_model.dart';

import 'input_gas.dart';

class ContainerInput extends StatelessWidget {
  final TextEditingController newIntValueTextController;
  final TextEditingController newDecimalValueTextController;
  final MoneyMaskedTextController gasPriceTextController;
  final List<Leitura> listLeituras;
  // final Function dateSelection;
  final String dateText;
  final String datePressed;

  final textStyleValue = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  ContainerInput({
    Key key,
    @required this.gasPriceTextController,
    @required this.listLeituras,
    @required this.newIntValueTextController,
    @required this.newDecimalValueTextController,
    // @required this.dateSelection,
    @required this.dateText,
    @required this.datePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.black.withOpacity(0.8),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      elevation: 2,
      child: Container(
        width: 340,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Valor",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  InputGas(
                    newIntValueTextController: newIntValueTextController,
                    newDecimalValueTextController:
                        newDecimalValueTextController,
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Text(
                  //     "Pre??o kg/g??s",
                  //     style: Theme.of(context).textTheme.bodyText1,
                  //   ),
                  // ),
                  // InputPrice(
                  //   gasPriceController: gasPriceTextController,
                  // ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 10.0),
                  //   child: Text(
                  //     "Data",
                  //     style: Theme.of(context).textTheme.bodyText1,
                  //   ),
                  // ),
                  // InputDate(
                  //   dateText: dateText,
                  //   dateSelection: dateSelection,
                  //   datePressed: datePressed,
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
