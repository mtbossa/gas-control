import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:gas_mvc/app/helpers/database_helper.dart';
import 'package:gas_mvc/app/models/leitura_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HomeController {
  List<Leitura> listLeituras = [];

  TextEditingController newIntValueTextController;
  TextEditingController newDecimalValueTextController;
  MoneyMaskedTextController gasPriceTextController;

  // Variable to work with database
  final DatabaseHelper db = DatabaseHelper();

  // Controls the ID
  int indexId;

  String date;
  String dateText = "Outros...";
  String datePressed = "";
  DateFormat dateFormatDataBase = DateFormat("dd - MM - yyyy");
  DateFormat dateFormatCalendar;

  HomeController({
    this.newIntValueTextController,
    this.newDecimalValueTextController,
    this.gasPriceTextController,
  });

  /* value is just a name for the variable that will hold
   * the returned value, could be any other name.
   */
  // void exhibitAllContatos() {
  //   db.getAllLeituras().then((value) {
  //     listLeituras = value;

  //   });
  // }

  Future<void> exhibitAllContatos() async {
    await db.getAllLeituras().then((value) {
      listLeituras = value;
      print("Inside exhibitAllContatos(): value --> $value");
      print("Inside exhibitAllContatos(): listLeituras --> $listLeituras");
    });
  }

  // Function that zero's all content inside Gas object
  void zeroValues() {
    listLeituras.clear();
    db.deleteAll();
    exhibitAllContatos();
  }

  // Function that returns the last value
  void revertLastValue() {
    listLeituras.removeLast();
    db.deleteLastLeitura();
    exhibitAllContatos();
  }

  initDateFormatting() {
    initializeDateFormatting("pt_BR", null)
        .then((_) => dateFormatCalendar = DateFormat.MMMd("pt_BR"));
  }

  void resetDateFields() {
    datePressed = "";
    dateText = "Outros ...";
  }

  void calculate() {
    String _newIntValueText = newIntValueTextController.text;
    String _newDecimalValueText = newDecimalValueTextController.text;
    String _gasPriceText = gasPriceTextController.text;

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

    if (listLeituras.length > 0) {
      _cubicMeterDifference =
          _cubicMeterValue - listLeituras.last.cubicMeterValue;
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

    if (date == null) {
      DateTime now = DateTime.now();
      date = DateFormat("dd - MM - yyyy").format(now);
    }

    if ((listLeituras.length == 0 && _cubicMeterValue > 0) ||
        (listLeituras.length > 0 &&
            _cubicMeterValue > 0 &&
            _cubicMeterDifference > 0)) {

      indexId = listLeituras.length;

      Leitura leitura = Leitura(
        id: indexId,
        cubicMeterValue: _cubicMeterValue,
        cubicMeterDifference: _cubicMeterDifference,
        kgValue: _kgValue,
        gasPrice: _gasPrice,
        moneyValue: _moneyValue,
        date: date,
      );
      
      print(
          "Inside calcultate() before listleituras.add(leitura): leitura criada: $leitura");
      listLeituras.add(leitura);
      print(
          "Inside calcultate() after listleituras.add(leitura): leitura criada: $leitura");
      print(
          "Inside calcultate() after listleituras.add(leitura): listLeituras: $listLeituras");
      db.insertLeitura(leitura);
      print(
          "Inside calcultate() after db.insertLeitura(leitura): leitura: $leitura");
      print(
          "Inside calcultate() after db.insertLeitura(leitura): listLeituras: $listLeituras");
    }
    clearTextFields();
    resetDateFields();
  }

  void clearTextFields() {
    newIntValueTextController.clear();
    newDecimalValueTextController.clear();
  }

  void clearPriceField() {
    gasPriceTextController.clear();
  }
}
