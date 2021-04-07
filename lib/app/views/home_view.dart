import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gas_mvc/app/components/home_view/container_input.dart';
import 'package:gas_mvc/app/components/home_view/container_values.dart';
import 'package:gas_mvc/app/constants/constants.dart';
import 'package:gas_mvc/app/controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController _homeController;

  int _currentIndex; // Current index of result view

  TextEditingController _newIntValueTextController = TextEditingController();
  TextEditingController _newDecimalValueTextController =
      TextEditingController();
  MoneyMaskedTextController _gasPriceTextController =
      MoneyMaskedTextController();

  final textStyleTitle = TextStyle(
    fontSize: 17,
  );

  final textStyleValue = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    _homeController = HomeController(
      newIntValueTextController: _newIntValueTextController,
      newDecimalValueTextController: _newDecimalValueTextController,
      gasPriceTextController: _gasPriceTextController,
    );

    _homeController.exhibitAllContatos().then((_) {
      setState(() {
        print("Done");
      });
    });

    // _homeController.db.getAllLeituras().then((value) {
    //   setState(() {
    //     _homeController.listLeituras = value;
    //   });
    //   print("Inside initState: value --> $value");
    //   print(
    //       "Inside initState: listLeituras --> ${_homeController.listLeituras}");
    // });

    _homeController.initDateFormatting();
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: PopupMenuButton(
              onSelected: choiceAction,
              itemBuilder: (context) {
                return Constants.Choices.map((String choice) {
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
          "Controle",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          SafeArea(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      ContainerValues(
                        listLeituras: _homeController.listLeituras,
                        onChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        currentIndex: _currentIndex,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Adicionar nova leitura",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ContainerInput(
                        newDecimalValueTextController:
                            _newDecimalValueTextController,
                        newIntValueTextController: _newIntValueTextController,
                        gasPriceTextController: _gasPriceTextController,
                        listLeituras: _homeController.listLeituras,
                        //TODO
                        // dateSelection: _homeController.dateSelection,
                        date: _homeController.date,
                        dateText: _homeController.dateText,
                        datePressed: _homeController.datePressed,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          setState(() {
                            _homeController.calculate();
                          });
                        },
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                Text("Tem certeza que deseja"),
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
                  _homeController.zeroValues();
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

  // Revert last added value
  _revertLastValueDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Voltar leitura",
          ),
          content: Container(
            height: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Tem certeza que deseja"),
                Text("voltar uma leitura?"),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "CANCELAR",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text(
                "OK",
              ),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _homeController.revertLastValue();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void clearTextFields() {
    _newIntValueTextController = TextEditingController();
    _newDecimalValueTextController = TextEditingController();
  }

  void clearPriceField() {
    _gasPriceTextController = MoneyMaskedTextController();
  }

  // Function that does something depeding on choice
  void choiceAction(String choice) {
    if (choice == Constants.voltarLeitura) {
      _revertLastValueDialog(context);
    } else if (choice == Constants.zerarValores) {
      _zeroAllValuesDialog(context);
    }
  }
}
