import 'package:flutter/material.dart';
import 'package:gas_mvc/app/components/home_view/page_view_result.dart';
import 'package:gas_mvc/app/models/leitura_model.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'dots_result.dart';

class ContainerValues extends StatelessWidget {
  final ValueChanged<int> onChanged;
  final int currentIndex;
  final List<Leitura> listLeituras;
  final _fCubicMeter = NumberFormat("####0.000", Platform.localeName);

  ContainerValues({
    Key key,
    @required this.listLeituras,
    @required this.onChanged,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.black.withOpacity(0.8),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Leitura atual
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Leitura Anterior",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      checkEmptyAnterior(context),
                    ],
                  ),
                  // Leitura anterior
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Leitura Atual",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      checkEmptyAtual(context),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    "Resultados",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  PageViewResult(
                    listLeituras: listLeituras,
                    onChanged: onChanged,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DotsResult(
                    currentIndex: currentIndex,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text checkEmptyAnterior(BuildContext context) {
    var secondToLastElement;

    if (listLeituras.length >= 2) {
      secondToLastElement = listLeituras[listLeituras.length - 2];

      if (listLeituras.isEmpty ||
          secondToLastElement.cubicMeterValue == 0.0 ||
          secondToLastElement.cubicMeterValue == null) {
        return Text(
          "${_fCubicMeter.format(0.000)} m³",
          style: Theme.of(context).textTheme.bodyText2,
        );
      } else {
        return Text(
          // Displays the most recent added gas value
          "${_fCubicMeter.format(secondToLastElement.cubicMeterValue)} m³",
          style: Theme.of(context).textTheme.bodyText2,
        );
      }
    } else {
      return Text(
        "${_fCubicMeter.format(0.000)} m³",
        style: Theme.of(context).textTheme.bodyText2,
      );
    }
  }

  Text checkEmptyAtual(BuildContext context) {
    var lastElement;

    if (listLeituras.isNotEmpty) {
      lastElement = listLeituras.last;
      if (lastElement.cubicMeterValue == 0.0 ||
          lastElement.cubicMeterValue == null) {
        return Text(
          "${_fCubicMeter.format(0.000)} m³",
          style: Theme.of(context).textTheme.bodyText2,
        );
      } else {
        return Text(
          // Displays the most recent added gas value
          "${_fCubicMeter.format(lastElement.cubicMeterValue)} m³",
          style: Theme.of(context).textTheme.bodyText2,
        );
      }
    } else {
      return Text(
        "${_fCubicMeter.format(0.000)} m³",
        style: Theme.of(context).textTheme.bodyText2,
      );
    }
  }
}
