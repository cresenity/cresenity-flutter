



import 'package:shared_preferences/shared_preferences.dart';

import '../adapter.dart';

class SharedPreferencesAdapter extends Adapter {
  SharedPreferences _prefs;
  Future<void> setup() async {
    _prefs = await SharedPreferences.getInstance();
  }
  String get(String key,{String defaultValue})  {
    
    if(_prefs.containsKey(key)) {
      return _prefs.getString(key);
    }
    return defaultValue;
  }

  Future<bool> put(String key,String value) {
    return _prefs.setString(key, value);
  }

  Future<bool> unset(String key) {
    return _prefs.remove(key);
  }
}
