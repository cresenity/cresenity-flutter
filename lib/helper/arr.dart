
import '../support/caster.dart';
import '../support/collection.dart';
import '../support/array.dart';
import 'c.dart';
class Arr {
  static bool accessible(array) {
    return array!=null && (array is Map || array is List);
  }

  static bool exists(array,key) {


    if(array is Map) {

      return array.containsKey(key);
    }
    if(array is List) {
      if(!key is int) {
        key = Caster(key).toInt();
      }
      return array.length>=key && key>=0;
    }


    return false;

  }

  static get(array, key,{dynamic defaultValue}) {

    if(!accessible(array) || key==null || !C.isScalar(key)) {
      return defaultValue;
    }
    if(array is Map) {
      if(array.containsKey(key)) {
        return array[key];
      }
    }

    if(array is List) {
      int keyInt = Caster(key).toInt();
      if(keyInt>=0 && keyInt<=array.length) {
        return array[keyInt];
      }
    }
    if(key.indexOf('.')>0) {
      print(key);
       for(var segment in key.split(".")) {


         if(accessible(array) && exists(array, segment)) {

            array = array[segment];
          } else {
            return defaultValue;
          }
       }
    }
    return array;

  }

  static String getString(map, key,{String defaultValue}) {

    var value = get(map,key,defaultValue: defaultValue);

    return Caster(value).toString();

  }


  static int getInt(map, key,{int defaultValue}) {
    var value = get(map,key,defaultValue: defaultValue);
    return Caster(value).toInt();
  }


  static Collection getCollection(map, key,{Collection defaultValue}) {
    var value = get(map,key,defaultValue: defaultValue);

    if(value!=null && (!(value is Collection))) {
      return Collection(items:value);
    }
    return value;
  }

  static Array getArray(map, key,{Array defaultValue}) {
    var value = get(map,key,defaultValue: defaultValue);

    if(value!=null && (!(value is Array))) {
      return Array(items:value);
    }
    return value;
  }

  static Map getMap(map, key,{Array defaultValue}) {
    var value = get(map,key,defaultValue: defaultValue);


    return value;
  }

}