import 'package:flutter/material.dart';
import 'package:gas_mvc/app/models/gas_model.dart';

class PageViewResult extends StatelessWidget {
  final ValueChanged<int> onChanged;
  final Gas gas;

  const PageViewResult({
    Key key,
    @required this.onChanged,
    @required this.gas,
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
    if (gas.gasCubicMetersValue == 0.0 || gas.gasCubicMetersValue == null) {
      return Text(
        "0.0",
        style: TextStyle(
          fontSize: 25,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        "${gas.gasCubicMetersValue.toStringAsFixed(2)}",
        style: TextStyle(
          fontSize: 25,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  Text checkKg() {
    if (gas.gasKgValue == 0.0 || gas.gasKgValue == null) {
      return Text(
        "0.0",
        style: TextStyle(
          fontSize: 25,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        "${gas.gasKgValue.toStringAsFixed(3)}",
        style: TextStyle(
          fontSize: 25,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  Text checkMoney() {
    if (gas.gasMoneyValue == 0.0 || gas.gasKgValue == null) {
      return Text(
        "0.0",
        style: TextStyle(
          fontSize: 25,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Text(
        "${gas.gasMoneyValue.toStringAsFixed(2)}",
        style: TextStyle(
          fontSize: 25,
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}
