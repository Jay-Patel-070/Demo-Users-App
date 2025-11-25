import 'dart:convert';

import 'package:demo_users_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> saveData(String key, dynamic value) async {
    if (_prefs == null) await init(); // Ensure initialization
    if (value is String) {
      return _prefs!.setString(key, value);
    } else if (value is int) {
      return _prefs!.setInt(key, value);
    } else if (value is bool) {
      return _prefs!.setBool(key, value);
    } else if (value is double) {
      return _prefs!.setDouble(key, value);
    } else if (value is List<String>) {
      return _prefs!.setStringList(key, value);
    }
    return false;
  }

  dynamic getData(String key) {
    if (_prefs == null) return null;

    return _prefs!.get(key);
  }

  Future<bool> removeData(String key) async {
    if (_prefs == null) await init();
    return _prefs!.remove(key);
  }

  // Method to clear all data
  Future<bool> clearAllData() async {
    if (_prefs == null) await init();
    userData = null;
    return _prefs!.clear();
  }
}