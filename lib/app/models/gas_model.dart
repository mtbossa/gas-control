class Gas {
  /*
   * Value for converting the difference between the 
   * newGasValue and atualGasValue.
   * Formula: (newGasValue - atualGasValue) * conversionValueCubicMetersToKg.
   */
  final double conversionValueCubicMetersToKg = 2.5;
  /*
   * The last value read from the gas meter,
   * even after calculating, so the person can reset to last 
   * value
   */
  final double atualGasValue;
    /*
   * This will be the input value. 
   */
  final double newGasValue;
  /*
   * This value will be the same as newGasValue after
   * pressing the "CALCULAR" button, as it will become
   * the atualGasValue.
   * 
   */
  final double newAtualGasValue;
    /*
   * The price that the person pays for each
   * kg of gas.
   * Ex.: R$ 6,92
   * 
   */
  final double gasPrice;
  /*
   * This is the value from:
   * (newGasValue - atualGasValue) * conversionValueCubicMetersToKg
   */
  final double gasKgValue;
  /*
   * The amount of money spent on gas 
   */
  final double gasMoneyValue;

  Gas({
    this.atualGasValue,
    this.newGasValue,
    this.newAtualGasValue, 
    this.gasPrice, 
    this.gasKgValue,
    this.gasMoneyValue,
  });
}
