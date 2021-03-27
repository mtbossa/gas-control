class Leitura {
  double cubicMeterDifference = 0;

  double cubicMeterValue = 0;
  /*
   * This is the value from:
   * (newGasValue - atualGasValue) * conversionValueCubicMetersToKg
   */
  double kgValue = 0;
  /*
   * The price that the person pays for each
   * kg of gas.
   * Ex.: R$ 6,92
   * 
   */
  double gasPrice = 0;
  /*
   * The amount of money spent on gas.
   * gasPrice * kgValue;
   */
  double moneyValue = 0;
  // TODO implement this
  DateTime date;

  Leitura({
    this.cubicMeterDifference,
    this.cubicMeterValue,
    this.kgValue,
    this.gasPrice,
    this.moneyValue,
    this.date,
  });
}
