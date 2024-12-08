import 'package:shared_preferences/shared_preferences.dart';

/// [PersistentManager] provides static methods for setting and getting values from SharedPreferences.
class PersistentManager {
  static late SharedPreferences _sharedPreferences;

  /// Initializes the [SharedPreferences] instance.
  static Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Set an [int] value in SharedPreferences.
  static Future<void> setInt(String key, int value) async {
    await _sharedPreferences.setInt(key, value);
  }

  /// Get an [int] value from SharedPreferences.
  static int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  /// Set a [String] value in SharedPreferences.
  static Future<void> setString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }

  /// Get a [String] value from SharedPreferences.
  static String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  /// Set a [bool] value in SharedPreferences.
  static Future<void> setBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  /// Get a [bool] value from SharedPreferences.
  static bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  /// Set a [double] value in SharedPreferences.
  static Future<void> setDouble(
      {required String key, required double value}) async {
    await _sharedPreferences.setDouble(key, value);
  }

  /// Get a [double] value from SharedPreferences.
  static double? getDouble(String key) {
    return _sharedPreferences.getDouble(key);
  }

  /// Set a [List<String>] value in SharedPreferences.
  static Future<void> setStringList(
      {required String key, required List<String> value}) async {
    await _sharedPreferences.setStringList(key, value);
  }

  /// Get a [List<String>] value from SharedPreferences.
  static List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }

  /// Remove a value from SharedPreferences.
  static Future<void> remove(String key) async {
    await _sharedPreferences.remove(key);
  }

  /// Clear all values from SharedPreferences.
  static Future<void> clearAll() async {
    await _sharedPreferences.clear();
  }
}
