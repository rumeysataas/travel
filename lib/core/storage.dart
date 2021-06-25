import 'package:shared_preferences/shared_preferences.dart';

class Storage {                  //uygulamamızda telefona bilgi depolamak için kullanacağımız sınıf
  //init on the main function
  static SharedPreferences? preferences;

  static initialStorage() async {  //uygulamamızın main fonskiyonunda başlatıyoruz
    preferences = await SharedPreferences.getInstance();
  }

  static saveString(String key, String value) {     //string kayıt etmek için
    preferences?.setString(key, value);
  }

  static saveList(String key, List<String> value) {       //liste kayıt etmek için
    preferences?.setStringList(key, value);
  }

  static getString(String key) {                 //string değeri almak için
    return preferences?.getString(key);
  }

  static getList(String key) {                   //listeyi almak için
    return preferences?.getStringList(key);
  }

  static deleteStorage(String key) {              //silmek için
    preferences?.remove(key);
  }
}
