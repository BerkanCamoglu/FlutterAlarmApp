// ignore_for_file: camel_case_types, file_names, avoid_print
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _preferences;
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static void clearService() => _preferences.clear();

  static const String _kToken = 'token';
  static Future setToken(String userName) async {
    await _preferences.setString(_kToken, userName);
  }

  static bool isSignIn() {
    return _preferences.containsKey(_kToken);
  }

  static void clearToken() {
    _preferences.remove("token");
  }
}
