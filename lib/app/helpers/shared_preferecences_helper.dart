import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences _preferences;

  static const _keyConversionValue = 'conversionValue';
  static const _keyGasPrice = 'gasPrice';
  static const _keyInterstitialAdCounter = '_keyInterstitialAdCounter';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setConversionValue(double conversionValue) async =>
      await _preferences.setDouble(_keyConversionValue, conversionValue);

  static double getConversionValue() =>
      _preferences.getDouble(_keyConversionValue);

  static Future setGasPrice(double gasPrice) async =>
      await _preferences.setDouble(_keyGasPrice, gasPrice);

  static double getGasPrice() => _preferences.getDouble(_keyGasPrice);

  static Future setInterstitialAdCounter(int interstitialAdCounter) async =>
      await _preferences.setInt(
          _keyInterstitialAdCounter, interstitialAdCounter);

  static int getInterstitialAdCounter() => _preferences.getInt(_keyInterstitialAdCounter);
}
