import 'package:shared_preferences/shared_preferences.dart';

class sharedHelper  {

  static late SharedPreferences sharedPreferences;


 static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required bool value
  }) async {
   return await sharedPreferences.setBool(key, value);
  }


  getDate({required String key}) async{
   return await sharedPreferences.getBool(key);
  }

}