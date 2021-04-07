import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gas_mvc/app/components/home_view/input_price.dart';
import 'package:gas_mvc/app/models/leitura_model.dart';

import 'input_date.dart';
import 'input_gas.dart';

class ContainerInput extends StatelessWidget {
  final TextEditingController newIntValueTextController;
  final TextEditingController newDecimalValueTextController;
  final MoneyMaskedTextController gasPriceTextController;
  final List<Leitura> listLeituras;
  final Function dateSelection;
  final String date;
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
    this.dateSelection,
    @required this.date,
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
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Novo valor",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  InputGas(
                    newIntValueTextController: newIntValueTextController,
                    newDecimalValueTextController:
                        newDecimalValueTextController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Data",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  InputDate(
                    date: date,
                    dateText: dateText,
                    dateSelection: dateSelection,
                    datePressed: datePressed,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Preço kg/gás",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  InputPrice(
                    gasPriceController: gasPriceTextController,
                  ),
                  SizedBox(
                    height: 20,
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
