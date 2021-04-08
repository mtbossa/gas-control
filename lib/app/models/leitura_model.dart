class Leitura {
  int id;
  /*
   * Result of last add cubicMeterValue - the previously one
   */
  double cubicMeterDifference;
  /*
   * Last added cubicMeterValue;
   */
  double cubicMeterValue;
  /*
   * This is the value from:
   * (newGasValue - atualGasValue) * conversionValueCubicMetersToKg
   */
  double kgValue;
  /*
   * The price that the person pays for each
   * kg of gas.
   * Ex.: R$ 6,92
   */
  double gasPrice;
  /*
   * The amount of money spent on gas.
   * gasPrice * kgValue;
   */
  double moneyValue;
  /*
   * Date
   */
  String date;

  Leitura({
    this.id,
    this.cubicMeterDifference,
    this.cubicMeterValue,
    this.kgValue,
    this.gasPrice,
    this.moneyValue,
    this.date,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'cubicMeterDifference': cubicMeterDifference,
      'cubicMeterValue': cubicMeterValue,
      'kgValue': kgValue,
      'gasPrice': gasPrice,
      'moneyValue': moneyValue,
      'date': date,
    };
    return map;
  }

  Leitura.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    cubicMeterDifference = map['cubicMeterDifference'];
    cubicMeterValue = map['cubicMeterValue'];
    kgValue = map['kgValue'];
    gasPrice = map['gasPrice'];
    moneyValue = map['moneyValue'];
    date = map['date'];
  }

  @override
  String toString() {
    return "Leitura => (id: $id, cubicMeterDifference: $cubicMeterDifference, cubicMeterValue: $cubicMeterValue, kgValue: $kgValue, gasPrice: $gasPrice, moneyValue: $moneyValue, date: $date)";
  }
}