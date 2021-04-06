import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gas_mvc/app/components/home_view/input_price.dart';
import 'package:gas_mvc/app/models/gas_model.dart';

import 'input_date.dart';
import 'input_gas.dart';

class ContainerInput extends StatelessWidget {
  final TextEditingController newIntValueTextController;
  final TextEditingController newDecimalValueTextController;
  final MoneyMaskedTextController gasPriceTextController;
  final List<Leitura> listLeituras;

  final textStyleTitle = TextStyle(
    fontSize: 15,    
  );

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
        width: 280,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Preço kg/gás",
                      style: textStyleTitle,
                    ),
                  ),
                  InputPrice(
                    gasPriceController: gasPriceTextController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Nova leitura",
                      style: textStyleTitle,
                    ),
                  ),
                  InputGas(
                    newIntValueTextController: newIntValueTextController,
                    newDecimalValueTextController:
                        newDecimalValueTextController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Data",
                      style: textStyleTitle,
                    ),
                  ),
                  InputDate(),
                  SizedBox(
                    height: 10,
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
