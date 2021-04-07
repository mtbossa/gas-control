import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gas_mvc/app/components/home_view/container_input.dart';
import 'package:gas_mvc/app/components/home_view/container_values.dart';
import 'package:gas_mvc/app/components/home_view/input_gas_value(unused).dart';
import 'package:gas_mvc/app/constants/constants.dart';
import 'package:gas_mvc/app/helpers/database_helper.dart';
import 'package:gas_mvc/app/models/gas_model.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex; // Current index of result view

  // Variable to work with database
  DatabaseHelper db = DatabaseHelper();

  // List of Leitura
  List<Leitura> listLeituras = [];

  TextEditingController _newFirstIntValueTextController =
      TextEditingController();
  TextEditingController _newFirstDecimalValueTextController =
      TextEditingController();
  TextEditingController _newIntValueTextController = TextEditingController();
  TextEditingController _newDecimalValueTextController =
      TextEditingController();
  MoneyMaskedTextController _gasPriceTextController =
      MoneyMaskedTextController();

  String date;
  String dateText = "Outros...";
  String datePressed = "";

  final textStyleTitle = TextStyle(
    fontSize: 17,
  );

  final textStyleValue = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  @override
  void initState() {
    super.initState();    
    _currentIndex = 0;
    _exhibitAllContatos();
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
                if (listLeituras.length <= 0)
                  return Constants.firstChoice.map((String choice) {
                    return PopupMenuItem(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                else
                  return Constants.secondChoices.map((String choice) {
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
                        listLeituras: listLeituras,
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
                        listLeituras: listLeituras,
                        dateSelection: _dateSelection,
                        date: date,
                        dateText: dateText,
                        datePressed: datePressed,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          if (listLeituras.isNotEmpty) {
                            setState(() {
                              _calculate();
                            });
                          }
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
  _addNewGasValueDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Valor atual no medidor",
          ),
          content: Container(
            height: 58,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InputGasValue(
                    newIntValueTextController: _newFirstIntValueTextController,
                    newDecimalValueTextController:
                        _newFirstDecimalValueTextController),
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
              child: Text(
                "CANCELAR",
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _newFirstIntValueTextController = TextEditingController();
                _newFirstDecimalValueTextController = TextEditingController();
              },
            ),
            ElevatedButton(
              child: Text(
                "OK",
              ),
              onPressed: () {
                // TODO If value <= 0, snackbar, but dont close window
                Navigator.of(context).pop();
                setState(() {
                  _createFirstValue();
                });
              },
            ),
          ],
        );
      },
    );
  }

  // Function that creates the first input Value
  void _createFirstValue() {
    String newIntValueText = _newFirstIntValueTextController.text;
    String newDecimalValueText = _newFirstDecimalValueTextController.text;

    double newIntDoubleValue = double.tryParse(newIntValueText) ?? 0.0;
    double newDecimalDoubleValue =
        ((double.tryParse(newDecimalValueText) ?? 0.0) / 1000);

    double cubicMeterValue = newIntDoubleValue + newDecimalDoubleValue;

    if (cubicMeterValue > 0.0) {
      Leitura leitura = Leitura(
        cubicMeterValue: cubicMeterValue,
        cubicMeterDifference: 0.0,
        gasPrice: 0.0,
        kgValue: 0.0,
        moneyValue: 0.0,
      );
      db.insertLeitura(leitura);
      print("Leitura: $leitura");
      print("listLeituras.length: ${listLeituras.length}");
      _exhibitAllContatos();
      // print("Log Date: ${listLeituras.last.date}");
    } else {
      // TODO create snackbar saying that the value must be greater than 0. Stay in alert dialog
    }
    // Clear TextFields
    _clearTextFields();
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
                  _zeroValues();
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
    print(listLeituras);
    db.deleteAll();
    _exhibitAllContatos();

    // Clear TextFields
    _clearTextFields();
    _clearPriceField();
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
                  _revertLastValue();
                });
              },
            ),
          ],
        );
      },
    );
  }

  // Function that returns the last value
  _revertLastValue() {
    db.deleteLastLeitura();
    _exhibitAllContatos();
    _clearTextFields();
  }

  // Function that does something depeding on choice
  void choiceAction(String choice) {
    if (choice == Constants.adicionarLeitura) {
      _addNewGasValueDialog(context);
    } else if (choice == Constants.voltarLeitura) {
      _revertLastValueDialog(context);
    } else if (choice == Constants.zerarValores) {
      _zeroAllValuesDialog(context);
    }
  }

  // Function that calculates and displays the values
  void _calculate() {
    String newIntValueText = _newIntValueTextController.text;
    String newDecimalValueText = _newDecimalValueTextController.text;
    String gasPriceText = _gasPriceTextController.text;

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

    double moneyValue;

    if (gasPrice > 0.0) {
      moneyValue = kgValue * gasPrice;
    } else {
      moneyValue = 0.0;
    }

    if (date == null) {
      DateTime now = DateTime.now();
      date = DateFormat("dd - MM - yyyy").format(now);
    }

    if (cubicMeterValue > 0 && cubicMeterDifference > 0) {
      Leitura leitura = Leitura(
        cubicMeterValue: cubicMeterValue,
        cubicMeterDifference: cubicMeterDifference,
        kgValue: kgValue,
        gasPrice: gasPrice,
        moneyValue: moneyValue,
        date: date,
      );
      db.insertLeitura(leitura);
      print("listLeituras.length: ${listLeituras.length}");
      _exhibitAllContatos();
    }
    // TODO create snackbar saying that the value must be greater than previous.
    _clearTextFields();
    resetDateFields();
  }

  void _clearTextFields() {
    _newFirstIntValueTextController = TextEditingController();
    _newFirstDecimalValueTextController = TextEditingController();
    _newIntValueTextController = TextEditingController();
    _newDecimalValueTextController = TextEditingController();
  }

  void _clearPriceField() {
    _gasPriceTextController = MoneyMaskedTextController();
  }

  /* value is just a name for the variable that will hold
   * the returned value, could be any other name.
   */
  void _exhibitAllContatos() {
    db.getAllLeituras().then((value) {
      setState(() {
        listLeituras = value;
        print("Inside _exibeAllContatos: $value");
      });
    });
  }

  void _dateSelection(String dateSelection) {
    if (dateSelection == "Hoje") {
      setState(() {
        datePressed = "Hoje";
      });

      DateTime _now = DateTime.now();
      date = DateFormat("dd - MM - yyyy").format(_now);
      print("date: $date");
    } else if (dateSelection == "Ontem") {
      setState(() {
        datePressed = "Ontem";
      });

      DateTime _now = DateTime.now().subtract(
        Duration(
          days: 1,
        ),
      );

      date = DateFormat("dd - MM - yyyy").format(_now);
      print("date ontem: $date");
    } else {
      datePressed = "Outros";
      print("date before show calendar: $date");

      _showCalendar(context);

      print("date after show calendar: $date");
      print("dateText: $dateText");
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
        date = DateFormat("dd - MM - yyyy").format(_pickedDate);
        dateText = DateFormat("dd/MMM").format(_pickedDate);
      }
    });

    print("date: $date");
  }

  void resetDateFields() {
    datePressed = "";
    dateText = "Outros ...";
  }
}
