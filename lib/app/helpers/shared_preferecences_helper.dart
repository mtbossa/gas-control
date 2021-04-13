import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences _preferences;

  static const _keyConversionValue = 'conversionValue';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setConversionValue(double conversionValue) async =>
      await _preferences.setDouble(_keyConversionValue, conversionValue);

  static double getConversionValue() => _preferences.getDouble(_keyConversionValue);
}
