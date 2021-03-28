import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gas_mvc/app/components/home_view/container_values.dart';
import 'package:gas_mvc/app/components/home_view/dots_result.dart';
import 'package:gas_mvc/app/components/home_view/input_gas_new_value.dart';
import 'package:gas_mvc/app/components/home_view/page_view_result.dart';
import 'package:gas_mvc/app/constants/constants.dart';
import 'package:gas_mvc/app/models/gas_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex; // Current index of result view

  TextEditingController newIntValueTextController = TextEditingController();
  TextEditingController newDecimalValueTextController = TextEditingController();
  MoneyMaskedTextController gasPriceTextController =
      MoneyMaskedTextController();
  bool _firstTime = true;
  List<Leitura> listLeituras = [];

  @override
  void initState() {
    super.initState();
    if (_firstTime) {
      Leitura _leitura = Leitura(
        cubicMeterDifference: 0.0,
        cubicMeterValue: 0.0,
        gasPrice: 0.0,
        kgValue: 0.0,
        moneyValue: 0.0,
      );
      listLeituras.insert(0, _leitura);
      _firstTime = !_firstTime;
    }
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: PopupMenuButton(
              onSelected: choiceAction,
              itemBuilder: (context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
              child: Icon(
                Icons.more_vert,
              ),
            ),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Controle gás",
        ),
      ),
      body: ListView(
        children: [
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Column(
                      children: [
                        ContainerValues(
                          newIntValueTextController: newIntValueTextController,
                          newDecimalValueTextController:
                              newDecimalValueTextController,
                          gasPriceTextController: gasPriceTextController,
                          leiturasArray: listLeituras,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _calculate();
                              newIntValueTextController =
                                  TextEditingController();
                              newDecimalValueTextController =
                                  TextEditingController();
                            }); // Calcular e mostrar
                          },
                          child: Text("CALCULAR"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "RESULTADOS",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PageViewResult(
                  arrayLeituras: listLeituras,
                  onChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                DotsResult(
                  currentIndex: _currentIndex,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // AlertDialog for adding newAtualGasValue
  _addNewGasValueDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Valor atual no medidor",
          ),
          content: Container(
            height: 38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputGasValue(
                    newIntValueTextController: newIntValueTextController,
                    newDecimalValueTextController:
                        newDecimalValueTextController),
                Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("CANCELAR"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _createFirstValue();
                  newIntValueTextController = TextEditingController();
                  newDecimalValueTextController = TextEditingController();
                });
              },
              child: Text(
                "OK",
              ),
            ),
          ],
        );
      },
    );
  }

  // Function that creates the first input Value
  void _createFirstValue() {
    String newIntValueText = newIntValueTextController.text;
    String newDecimalValueText = newDecimalValueTextController.text;

    double newIntDoubleValue = double.tryParse(newIntValueText) ?? 0.0;
    double newDecimalDoubleValue =
        ((double.tryParse(newDecimalValueText) ?? 0.0) / 1000);

    Leitura leitura = Leitura(
      cubicMeterValue: newIntDoubleValue + newDecimalDoubleValue,
      cubicMeterDifference: 0.0,
      date: DateTime.now(),
      gasPrice: 0.0,
      kgValue: 0.0,
      moneyValue: 0.0,
    );

    listLeituras.add(leitura);
  }

  // AlertDialog for adding newAtualGasValue
  _zeroAllValuesDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Zerar valores",
          ),
          content: Container(
            height: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Tem certeza que deseja "),
                Text("zerar todos os valores?"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("CANCELAR"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _zeroValues();
                  gasPriceTextController = MoneyMaskedTextController();
                });
              },
              child: Text(
                "OK",
              ),
            ),
          ],
        );
      },
    );
  }

  // Function that zero's all content inside Gas object
  void _zeroValues() {
    listLeituras.clear();
    Leitura _leitura = Leitura(
      cubicMeterDifference: 0.0,
      cubicMeterValue: 0.0,
      gasPrice: 0.0,
      kgValue: 0.0,
      moneyValue: 0.0,
    );
    listLeituras.insert(0, _leitura);
  }

  // Revert last added value
  void _revertLastValue() {}

  // Function that does something depeding on choice
  void choiceAction(String choice) {
    if (choice == Constants.adicionarLeitura) {
      _addNewGasValueDialog(context);
    } else if (choice == Constants.voltarLeitura) {
      _revertLastValue();
    } else if (choice == Constants.zerarValores) {
      _zeroAllValuesDialog(context);
    }
  }

  // Function that calculates and displays the values
  void _calculate() {
    String newIntValueText = newIntValueTextController.text;
    String newDecimalValueText = newDecimalValueTextController.text;
    String gasPriceText = gasPriceTextController.text;

    double gasPriceDoubleValue =
        double.parse(gasPriceText.replaceAll(new RegExp(r'[,.]'), '')) / 100;

    /*
     * Transform the text in double
     */
    double newIntDoubleValue = double.tryParse(newIntValueText) ?? 0.0;
    /* 
     * Divided by 1000 so it becomes 0,###, to be the
     * total value decimals
     */
    double newDecimalDoubleValue =
        ((double.tryParse(newDecimalValueText) ?? 0.0) / 1000);

    double cubicMeterValue = newIntDoubleValue + newDecimalDoubleValue;

    double cubicMeterDifference =
        cubicMeterValue - listLeituras.last.cubicMeterValue;

    double kgValue = cubicMeterDifference * 2.5;

    double gasPrice = gasPriceDoubleValue;
    double moneyValue = kgValue * gasPrice;

    Leitura leitura = Leitura(
      cubicMeterValue: cubicMeterValue,
      cubicMeterDifference: cubicMeterDifference,
      kgValue: kgValue,
      gasPrice: gasPrice,
      moneyValue: moneyValue,
    );

    listLeituras.add(leitura); // TODO can't add if new value is 0.0

    print("lenght: ${listLeituras.length}");
    print("cubicMeterDifference: ${listLeituras.last.cubicMeterDifference}");
    print("cubicMeterValue: ${listLeituras.last.cubicMeterValue}");
  }
}
