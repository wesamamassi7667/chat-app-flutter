import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class UtilSharedPreference{
 static SharedPreferences? _pref;

 static Future<SharedPreferences> load() async {
    if(_pref==null){
      _pref=await SharedPreferences.getInstance();
    }
    return _pref!;
  }


  static Future<void> setObj(String key,Object value) async {
    _pref!.setString(key, jsonEncode(value));
  }

  static Object? getObj(String key) async {
   if(_pref!.getString(key)!=null){
    return  jsonDecode(_pref!.getString(key)!);
   }
   return null;
 }

 static void setString(String key, String value) {
   _pref!.setString(key, value);
 }

 static String? getString(String key) {
   if (_pref!.getString(key) != null) {
     return _pref!.getString(key)!;
   }
   return null;
 }






}