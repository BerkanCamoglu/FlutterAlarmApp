// ignore_for_file: camel_case_types, file_names, avoid_print
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _preferences;
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static void clearService() => _preferences.clear();

  static const String _kToken = 'filePath';
  static Future setFilePath(String userName) async {
    await _preferences.setString(_kToken, userName);
  }

  static Future<String> getFilePath() async {
    return _preferences.getString(_kToken).toString();
  }

  static void clearFilePath() {
    _preferences.remove("token");
  }
}
