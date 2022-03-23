import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  ///INSTANCE OF SHARED PREFERENCES
  static late SharedPreferences sharedPreferences;

  ///INITIALIZATION OF SHARED PREFERENCES OBJECT
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  ///SET BOOLEAN DATA
  static Future<bool> setBooleanData(
      {required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  ///GET BOOLEAN DATA
  static bool? getBooleanData({required String key}) {
    return sharedPreferences.getBool(key);
  }

  ///SET STRING DATA
  static Future<bool> setStringData(
      {required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  ///GET STRING DATA
  static String? getStringData({required String key}) {
    return sharedPreferences.getString(key);
  }

  ///REMOVE FROM SHARED PREFERENCES
  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
