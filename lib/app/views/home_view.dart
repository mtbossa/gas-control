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

  TextEditingController newIntValueTextController =
      TextEditingController(text: "0");
  TextEditingController newDecimalValueTextController =
      TextEditingController(text: "000");
  MoneyMaskedTextController gasPriceTextController =
      MoneyMaskedTextController();
  List<Leitura> listLeituras = [];

  @override
  void initState() {
    super.initState();
    Leitura leitura = Leitura(
      cubicMeterDifference: 0.0,
      cubicMeterValue: 0.0,
      gasPrice: 0.0,
      kgValue: 0.0,
      moneyValue: 0.0,
    );
    listLeituras.insert(0, leitura);
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
                              calculate();
                              newIntValueTextController = TextEditingController(text: "0");
                              newDecimalValueTextController = TextEditingController(text: "000");
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
  addNewGasValueDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Valor atual no medidor",
          ),
          content: Container(
            height: 28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputGasValue(
                    newIntValueTextController: newIntValueTextController,
                    newDecimalValueTextController:
                        newDecimalValueTextController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text("CANCELAR"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  createFirstValue();
                  newIntValueTextController = TextEditingController(text: "0");
                  newDecimalValueTextController = TextEditingController(text: "000");
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
  void createFirstValue() {
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
  zeroAllValuesDialog(BuildContext context) {
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
              onPressed: () {},
              child: Text("CANCELAR"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  zeroValues();
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
  void zeroValues() {
    listLeituras.clear();
  }

  // Revert last added value
  void revertLastValue() {}

  // Function that does something depeding on choice
  void choiceAction(String choice) {
    if (choice == Constants.adicionarLeitura) {
      addNewGasValueDialog(context);
    } else if (choice == Constants.voltarLeitura) {
      revertLastValue();
    } else if (choice == Constants.zerarValores) {
      zeroAllValuesDialog(context);
    }
  }

  // Function that calculates and displays the values
  void calculate() {
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

    listLeituras.add(leitura);

    print("lenght: ${listLeituras.length}");
    print("cubicMeterDifference: ${listLeituras.last.cubicMeterDifference}");
    print("cubicMeterValue: ${listLeituras.last.cubicMeterValue}");
  }
}
