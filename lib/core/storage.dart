import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  //init on the main function
  static SharedPreferences? preferences;

  static initialStorage() async {
    preferences = await SharedPreferences.getInstance();
  }

  static saveString(String key, String value) {
    preferences?.setString(key, value);
  }

  static saveList(String key, List<String> value) {
    preferences?.setStringList(key, value);
  }

  static getString(String key) {
    return preferences?.getString(key);
  }

  static getList(String key) {
    return preferences?.getStringList(key);
  }

  static deleteStorage(String key) {
    preferences?.remove(key);
  }
}
