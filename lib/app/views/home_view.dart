import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gas_mvc/app/components/home_view/container_input.dart';
import 'package:gas_mvc/app/components/home_view/container_values.dart';
import 'package:gas_mvc/app/constants/constants.dart';
import 'package:gas_mvc/app/helpers/database_helper.dart';
import 'package:gas_mvc/app/models/gas_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex; // Current index of result view

  // Variable to work with database
  DatabaseHelper _db = DatabaseHelper();

  // List of Leitura
  List<Leitura> _listLeituras = [];

  TextEditingController _newIntValueTextController = TextEditingController();
  TextEditingController _newDecimalValueTextController =
      TextEditingController();
  MoneyMaskedTextController _gasPriceTextController =
      MoneyMaskedTextController();

  String _date;
  String _dateText = "Outros...";
  String _datePressed = "";
  DateFormat _dateFormatDataBase = DateFormat("dd - MM - yyyy");
  DateFormat _dateFormatCalendar;

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
    initializeDateFormatting("pt_BR", null)
        .then((_) => _dateFormatCalendar = DateFormat.MMMd("pt_BR"));
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
                        listLeituras: _listLeituras,
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
                        listLeituras: _listLeituras,
                        dateSelection: _dateSelection,
                        date: _date,
                        dateText: _dateText,
                        datePressed: _datePressed,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FloatingActionButton(
                        backgroundColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          setState(() {
                            _calculate();
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
    _listLeituras.clear();
    print(_listLeituras);
    _db.deleteAll();
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
    _db.deleteLastLeitura();
    _exhibitAllContatos();
    _clearTextFields();
  }

  // Function that does something depeding on choice
  void choiceAction(String choice) {
    if (choice == Constants.voltarLeitura) {
      _revertLastValueDialog(context);
    } else if (choice == Constants.zerarValores) {
      _zeroAllValuesDialog(context);
    }
  }

  // Function that calculates and displays the values
  void _calculate() {
    String _newIntValueText = _newIntValueTextController.text;
    String _newDecimalValueText = _newDecimalValueTextController.text;
    String _gasPriceText = _gasPriceTextController.text;

    double _gasPriceDoubleValue =
        double.parse(_gasPriceText.replaceAll(new RegExp(r'[,.]'), '')) / 100;

    /*
     * Transform the text in double
     */
    double _newIntDoubleValue = double.tryParse(_newIntValueText) ?? 0.0;
    /* 
     * Divided by 1000 so it becomes 0,###, to be the
     * total value decimals
     */
    double _newDecimalDoubleValue =
        ((double.tryParse(_newDecimalValueText) ?? 0.0) / 1000);

    double _cubicMeterValue = _newIntDoubleValue + _newDecimalDoubleValue;
    double _cubicMeterDifference;
    double _kgValue;
    double _gasPrice;
    double _moneyValue;

    if (_listLeituras.length > 0) {
      _cubicMeterDifference =
          _cubicMeterValue - _listLeituras.last.cubicMeterValue;
      _kgValue = _cubicMeterDifference * 2.5;

      _gasPrice = _gasPriceDoubleValue;

      if (_gasPrice > 0.0) {
        _moneyValue = _kgValue * _gasPrice;
      } else {
        _moneyValue = 0.0;
      }
    } else {
      _cubicMeterDifference = 0.0;
      _kgValue = 0.0;
      _gasPrice = 0.0;
      _moneyValue = 0.0;
    }

    if (_date == null) {
      DateTime now = DateTime.now();
      _date = DateFormat("dd - MM - yyyy").format(now);
    }

    if (_cubicMeterValue > 0) {
      Leitura leitura = Leitura(
        cubicMeterValue: _cubicMeterValue,
        cubicMeterDifference: _cubicMeterDifference,
        kgValue: _kgValue,
        gasPrice: _gasPrice,
        moneyValue: _moneyValue,
        date: _date,
      );
      _db.insertLeitura(leitura);
      print("listLeituras.length: ${_listLeituras.length}");
       print("leituras: $leitura");
      _exhibitAllContatos();
    }
    _clearTextFields();
    resetDateFields();
  }

  void _clearTextFields() {
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
    _db.getAllLeituras().then((value) {
      setState(() {
        _listLeituras = value;
        print("Inside _exibeAllContatos: $value");
      });
    });
  }

  void _dateSelection(String dateSelection) {
    if (dateSelection == "Hoje") {
      setState(() {
        _datePressed = "Hoje";
      });

      DateTime _now = DateTime.now();
      _date = DateFormat("dd - MM - yyyy").format(_now);
      print("date: $_date");
    } else if (dateSelection == "Ontem") {
      setState(() {
        _datePressed = "Ontem";
      });

      DateTime _now = DateTime.now().subtract(
        Duration(
          days: 1,
        ),
      );

      _date = DateFormat("dd - MM - yyyy").format(_now);
      print("date ontem: $_date");
    } else {
      _datePressed = "Outros";
      print("date before show calendar: $_date");

      _showCalendar(context);

      print("date after show calendar: $_date");
      print("dateText: $_dateText");
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
        _date = _dateFormatDataBase.format(_pickedDate);
        _dateText = _dateFormatCalendar.format(_pickedDate);
      }
    });

    print("date: $_date");
  }

  void resetDateFields() {
    _datePressed = "";
    _dateText = "Outros ...";
  }
}
