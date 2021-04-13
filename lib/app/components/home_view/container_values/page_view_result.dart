import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gas_mvc/app/models/leitura_model.dart';
import 'package:intl/intl.dart';

class PageViewResult extends StatelessWidget {
  final ValueChanged<int> onChanged;
  final List<Leitura> listLeituras;
  final _fCubicMeterKg = NumberFormat("####0.000", Platform.localeName);
  final _fMoney = NumberFormat("####0.00", Platform.localeName);
  final String remainingAmount;
  final String remainingText;

  PageViewResult({
    Key key,
    @required this.onChanged,
    @required this.listLeituras,
    @required this.remainingAmount,
    @required this.remainingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 98,
        child: PageView(
          onPageChanged: onChanged,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  checkCubicMeters(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "m³",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  checkKg(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "kg/gás",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  checkMoney(context),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text("R\$",
                        style: Theme.of(context).textTheme.headline3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text checkCubicMeters(BuildContext context) {
    if (listLeituras.isEmpty ||
        listLeituras.last.cubicMeterValue == 0.0 ||
        listLeituras.last.cubicMeterValue == null ||
        listLeituras.last.cubicMeterDifference == 0.0) {
      return Text(
        "Adicione $remainingAmount $remainingText para mostrar resultados",
        style: Theme.of(context).textTheme.bodyText2,
      );
    } else {
      return Text(
        "${_fCubicMeterKg.format(listLeituras.last.cubicMeterDifference)}",
        style: Theme.of(context).textTheme.headline1,
      );
    }
  }

  Text checkKg(BuildContext context) {
    if (listLeituras.isEmpty ||
        listLeituras.last.kgValue == 0.0 ||
        listLeituras.last.kgValue == null ||
        listLeituras.last.cubicMeterDifference == 0.0) {
      return Text(
        "Adicione $remainingAmount $remainingText para mostrar resultados",
        style: Theme.of(context).textTheme.bodyText2,
      );
    } else {
      return Text(
        "${_fCubicMeterKg.format(listLeituras.last.kgValue)}",
        style: Theme.of(context).textTheme.headline1,
      );
    }
  }

  Text checkMoney(BuildContext context) {
    if (listLeituras.isEmpty || listLeituras.last.cubicMeterDifference == 0.0) {
      return Text(
        "Adicione $remainingAmount $remainingText para mostrar resultados",
        style: Theme.of(context).textTheme.bodyText2,
      );
    } else if (listLeituras.last.moneyValue == 0.0 ||
        listLeituras.last.moneyValue == null) {
      return Text(
        "${_fMoney.format(0.00)}",
        style: Theme.of(context).textTheme.headline1,
      );
    } else {
      return Text(
        "${_fMoney.format(listLeituras.last.moneyValue)}",
        style: Theme.of(context).textTheme.headline1,
      );
    }
  }
}
