import 'package:shared_preferences/shared_preferences.dart';
class UtilSharedPreference{
 static SharedPreferences? _pref;

 static Future<SharedPreferences> load() async {
    if(_pref==null){
      _pref=await SharedPreferences.getInstance();
    }
    return _pref!;
  }
}