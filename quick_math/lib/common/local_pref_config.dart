import 'package:shared_preferences/shared_preferences.dart';

class LocalPrefConfig{
  static SharedPreferences? prefs;
  static Future<void> initPref()async{
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool?> setBool(String key, bool value)async{
    return prefs?.setBool(key, value);
  }
  static Future<bool?> readBool(String key)async{
    return prefs?.getBool(key);
  }

  static Future<bool?> setString(String key, String value)async{
    return prefs?.setString(key, value);
  }
  static Future<String?> getString(String key)async{
    return prefs?.getString(key);
  }

  static Future<bool?> removeString(String key){
    return prefs!.remove(key);
  }
}

class LocalPrefConstant{
  static const String isMusic = "is_music";
  static const String idUser = "id_user";
}