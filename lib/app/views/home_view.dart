import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gas_mvc/app/components/home_view/container_input.dart';
import 'package:gas_mvc/app/components/home_view/container_values/container_values.dart';
import 'package:gas_mvc/app/constants/constants.dart';
import 'package:gas_mvc/app/controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController _homeController;

  int _currentIndex; // Current index of result view

  String _dateText = "Outros...";
  String _datePressed = "";

  String remainingAmount = "duas";
  String remainingText = "leituras";

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
                        remainingAmount: remainingAmount,
                        remainingText: remainingText,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Adicionar nova leitura",
                        style: Theme.of(context).textTheme.headline2,
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
                        dateSelection: _dateSelection,
                        dateText: _dateText,
                        datePressed: _datePressed,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          setState(() {
                            _homeController.calculate();
                            checkIndex();
                            resetDateFields();
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
                  checkIndex();
                  print("mateus: ${_homeController.listLeituras}");
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

  // Function that does something depeding on choice
  void choiceAction(String choice) {
    if (choice == Constants.voltarLeitura) {
      _revertLastValueDialog(context);
    } else if (choice == Constants.zerarValores) {
      _zeroAllValuesDialog(context);
    }
  }

  // TODO if trying to add leitura with date less than the last one, dont let add to array and database
  // and show snackbar saying that it's not possible to added a leitura with less date than the last one
  // added
  void _dateSelection(String dateSelection) {
    if (dateSelection == "Hoje") {
      setState(() {
        _datePressed = "Hoje";
      });

      _homeController.atualDate = DateTime.now();
    } else if (dateSelection == "Ontem") {
      setState(() {
        _datePressed = "Ontem";
      });

      _homeController.atualDate = DateTime.now().subtract(
        Duration(
          days: 1,
        ),
      );
    } else {
      _datePressed = "Outros";
      _showCalendar(context);
    }
  }

  Future<Null> _showCalendar(BuildContext context) async {
    DateTime _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.grey[800],
              onPrimary: Colors.white,
              surface: Colors.grey[800],
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.grey[600],
          ),
          child: child,
        );
      },
    );
    setState(() {
      if (_pickedDate != null) {
        _homeController.atualDate = _pickedDate;
        _dateText = _homeController.dateFormatCalendar.format(_pickedDate);
      }
    });
  }

  void resetDateFields() {
    _datePressed = "";
    _dateText = "Outros ...";
  }

  void checkIndex() {
    if (_homeController.listLeituras.length == 0) {
      remainingAmount = "duas";
      remainingText = "leituras";
    }
    if (_homeController.listLeituras.length == 1) {
      remainingAmount = "uma";
      remainingText = "leitura";
    }
  }
}
