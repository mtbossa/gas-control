class Leitura {
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
   * Date when CALCULATE is pressed.
   */
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
