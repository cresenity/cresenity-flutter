


import '../adapter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveAdapter extends Adapter {

  final String boxKey = 'CFHive';

  void setup() async {
    await Hive.initFlutter();
    await Hive.openBox(boxKey);
  }
  String get(String key,{String defaultValue})  {
    var box = Hive.box(boxKey);



    return box.get(key,defaultValue: defaultValue);

  }

  Future<bool> put(String key,String value) {
    var box = Hive.box(boxKey);
    return box.put(key, value);
  }

  Future<bool> unset(String key) {
    var box = Hive.box(boxKey);
    return box.delete(key);
  }





}
