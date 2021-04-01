import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gas_mvc/app/models/gas_model.dart';
import 'package:intl/intl.dart';

class PageViewResult extends StatelessWidget {
  final ValueChanged<int> onChanged;
  final List<Leitura> listLeituras;
  final _fCubicMeterKg = NumberFormat("####0.000", Platform.localeName);
  final _fMoney = NumberFormat("####0.00", Platform.localeName);

  PageViewResult({
    Key key,
    @required this.onChanged,
    @required this.listLeituras,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: PageView(
          onPageChanged: onChanged,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              child: Column(
                children: [
                  checkCubicMeters(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "m³",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(12),
              //   ),
              // ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  checkKg(),
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: Text(
                      "kg/gás",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  checkMoney(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "R\$",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text checkCubicMeters() {
    if (listLeituras.isEmpty ||
        listLeituras.last.cubicMeterValue == 0.0 ||
        listLeituras.last.cubicMeterValue == null ||
        listLeituras.last.cubicMeterDifference == 0.0) {
      return Text(
        "${_fCubicMeterKg.format(0.000)}",
        style: TextStyle(
          fontSize: 25,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        "${_fCubicMeterKg.format(listLeituras.last.cubicMeterDifference)}",
        style: TextStyle(
          fontSize: 25,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  Text checkKg() {
    if (listLeituras.isEmpty ||
        listLeituras.last.kgValue == 0.0 ||
        listLeituras.last.kgValue == null) {
      return Text(
        "${_fCubicMeterKg.format(0.00)}",
        style: TextStyle(
          fontSize: 25,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        "${_fCubicMeterKg.format(listLeituras.last.kgValue)}",
        style: TextStyle(
          fontSize: 25,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  Text checkMoney() {
    if (listLeituras.isEmpty ||
        listLeituras.last.moneyValue == 0.0 ||
        listLeituras.last.moneyValue == null) {
      return Text(
        "${_fMoney.format(0.00)}",
        style: TextStyle(
          fontSize: 25,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        "${_fMoney.format(listLeituras.last.moneyValue)}",
        style: TextStyle(
          fontSize: 25,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
