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

  // Initial value 2.5. Can be changed. Saved in SharedPreferences
  double conversionValue = 2.5;

  // Can be changed. Saved in SharedPreferences
  double gasPrice;

  // Controls the ID
  int indexId;

  DateFormat dateFormatDataBase = DateFormat("dd / MM / yyyy");
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
    gasPriceTextController.updateValue(0.0);
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

  // Variables for calculate()
  double cubicMeterValue;
  double cubicMeterDifference;
  double kgValue;
  double moneyValue;
  DateTime atualDate;

  int getValues() {
    String _newIntValueText = newIntValueTextController.text;
    String _newDecimalValueText = newDecimalValueTextController.text;
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

    cubicMeterValue = _newIntDoubleValue + _newDecimalDoubleValue;

    if (cubicMeterValue > 0) {     

      if (atualDate == null) atualDate = DateTime.now();

      if (listLeituras.length == 0) {
        cubicMeterDifference = 0.0;
        kgValue = 0.0;
        moneyValue = 0.0;
        return 0;
      }

      if (listLeituras.length >= 1) {
        cubicMeterDifference =
            cubicMeterValue - listLeituras.last.cubicMeterValue;
        if (cubicMeterDifference > 0) {
          if (lastDateisBeforeAtualDate()) {
            kgValue = cubicMeterDifference * conversionValue;
            if (gasPrice > 0.0) {
              moneyValue = kgValue * gasPrice;
            } else {
              moneyValue = 0.0;
            }
            return 0;
          } else {
            clearTextFields();
            return 3;
          }
        } else {
          clearTextFields();
          return 2;
        }
      }
      return 0;
    } else {
      clearTextFields();
      return 1;
    }
  }

  void addToDatabase() {
    indexId = listLeituras.length;

    String date = dateFormatDataBase.format(atualDate);

    Leitura leitura = Leitura(
      id: indexId,
      cubicMeterValue: cubicMeterValue,
      cubicMeterDifference: cubicMeterDifference,
      kgValue: kgValue,
      moneyValue: moneyValue,
      date: date,
    );

    listLeituras.add(leitura);

    db.insertLeitura(leitura);

    clearTextFields();
  }

  void clearTextFields() {
    newIntValueTextController.clear();
    newDecimalValueTextController.clear();
  }

  void clearPriceField() {
    gasPriceTextController.afterChange("0,00", 0.00);
  }

  bool lastDateisBeforeAtualDate() {
    if (listLeituras.length > 0) {
      DateTime lastDate = dateFormatDataBase.parse(listLeituras.last.date);

      if (atualDate.isBefore(lastDate)) return false;
    }
    return true;
  }
}
