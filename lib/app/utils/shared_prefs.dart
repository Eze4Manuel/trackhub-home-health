import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  static saveStingList(String key, registeredMembers) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, registeredMembers);
  }
  static saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value.trim());
  }

  static readSingleString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var temp = prefs.getString(key);
    return temp;
  }
  static readStringList(String key) async {
    //Reading from local storage using shared preference
    final prefs = await SharedPreferences.getInstance();
    var temp = prefs.getStringList(key);
    return temp;
  }
  static remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }
}