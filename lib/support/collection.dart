
import 'dart:convert';

import 'caster.dart';
import '../helper/c.dart';
import '../helper/arr.dart';

class Collection {

  Map<String,dynamic> _items;

  Map<String,dynamic> all() {
    return _items;
  }

  Collection({Object items}) {
    _items = _getMapableItems(items);
    if(_items==null) {
      clear();
    }
  }


  Collection clear() {
    _items = Map<String,dynamic>();
  }

  Collection.fromJson(String json) {
     _items = jsonDecode(json);
  }

  _getMapableItems(Object items) {
    if(items==null) {
      return Map<String,dynamic>();
    }
    if (items is Collection) {
      return items.all();
    } else if(items is Map<String,dynamic>) {
      return items;
    } else if(items is Map<dynamic,dynamic>) {
      Map<String,dynamic> newItems = {};
      items.forEach((i, value) {
        Caster cast = Caster(i);
        newItems[cast.toString()] = value;
      });
      return newItems;
    } else if(items is List) {
      Map<String,dynamic> newItems = {};
      items.asMap().forEach((i, value) {
        newItems[i.toString()] = value;
      });
      return newItems;
    } else if(C.isScalar(items)) {

      Caster caster = Caster(items);
      Map<String,dynamic> newItems = {};
      newItems["0"] = items;
      return newItems;
    }

    return Map<String,dynamic>();
  }

  Iterable<String> get keys => _items.keys;

  Iterable<dynamic> get values => _items.values;


  operator [](dynamic key)  {
    String keyString = Caster(key).toString();
    return get(keyString);
  }

  dynamic get(String key,{defaultValue}) {
    return Arr.get(_items,key,defaultValue:defaultValue);

  }


  String toJson() {
    return jsonEncode(_items);
  }


  Collection merge(Collection other) {
    _items.addAll(other.all());
    return this;
  }


  int count() {
    return _items.length;
  }

  get length => count();
}