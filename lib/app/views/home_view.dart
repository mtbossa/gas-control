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

  // The first controller
  TextEditingController newFirstIntValueTextController =
      TextEditingController(text: "0");
  // The first decimal controller
  TextEditingController newFirstDecimalValueTextController =
      TextEditingController(text: "000");
  TextEditingController newIntValueTextController =
      TextEditingController(text: "0");
  TextEditingController newDecimalValueTextController =
      TextEditingController(text: "000");
  MoneyMaskedTextController gasPriceTextController =
      MoneyMaskedTextController();

  Gas gas = Gas();

  double newAtualGasValue;

  @override
  void initState() {
    super.initState();
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
                          gas: gas,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              calculate();
                            });
                            print(
                                "newIntValueTextController.text: ${newIntValueTextController.text}");
                            print(
                                "gas.newAtualGasValue: ${gas.newAtualGasValue}"); // Calcular e mostrar
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
                  gas: gas,
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
  addNewGasValue(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Valor atual no medidor",
          ),
          content: Container(
            height: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputGasValue(
                    newIntValueTextController: newFirstIntValueTextController,
                    newDecimalValueTextController:
                        newFirstDecimalValueTextController),
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
    String newIntValueText = newFirstIntValueTextController.text;
    String newDecimalValueText = newFirstDecimalValueTextController.text;

    double newIntDoubleValue = double.tryParse(newIntValueText) ?? 0.0;
    double newDecimalDoubleValue =
        ((double.tryParse(newDecimalValueText) ?? 0.0) / 1000);
    gas.newAtualGasValue = newIntDoubleValue + newDecimalDoubleValue;
    gas.atualGasValue = gas.newAtualGasValue;
  }

  // Revert last added value
  void revertLastValue() {}

  // Function that does something depeding on choice
  void choiceAction(String choice) {
    if (choice == Constants.adicionarLeitura) {
      addNewGasValue(context);
    } else if (choice == Constants.voltarLeitura) {
      revertLastValue();
    } else if (choice == Constants.zerarValores) {
      print("zerarValores");
    }
  }

  // Function that calculates and displays the values
  void calculate() {
    String newIntValueText = newIntValueTextController.text;
    String newDecimalValueText = newDecimalValueTextController.text;
    String gasPriceText = gasPriceTextController.text;

    double gasPriceDoubleValue = double.parse(gasPriceText.replaceAll(new RegExp(r'[,.]'), '')) / 100;

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
    gas.atualGasValue = gas.newAtualGasValue;

    gas.newAtualGasValue = newIntDoubleValue + newDecimalDoubleValue;

    gas.gasKgValue = (gas.newAtualGasValue - gas.atualGasValue) *
        gas.conversionValueCubicMetersToKg;

    gas.gasPrice = gasPriceDoubleValue;
    gas.gasMoneyValue = gas.gasKgValue * gas.gasPrice;

    print("gasPriceText: $gasPriceText");
    print("gasPriceDoubleValue: $gasPriceDoubleValue");
    print("gas.gasPrice: ${gas.gasPrice}");
    print("gas.gasKgValue: ${gas.gasKgValue}");
    print("gas.gasMoneyValue: ${gas.gasMoneyValue}");
  }
}
