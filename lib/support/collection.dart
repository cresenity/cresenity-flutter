
import 'dart:collection';
import 'dart:convert';

import 'caster.dart';
import '../helper/c.dart';
import '../helper/arr.dart';

class Collection<T> {

  Map<String,T> _items;

  Map<String,T> all() {
    return _items;
  }

  Collection({Object items}) {
    _items = _getMapableItems(items);
    if(_items==null) {
      clear();
    }
  }


  Collection clear() {
    _items = Map<String,T>();
  }

  Collection.fromJson(String json) {
     _items = jsonDecode(json);
  }

  _getMapableItems(Object items) {
    if(items==null) {
      return Map<String,T>();
    }
    if (items is Collection) {
      return items.all();
    } else if(items is Map<String,T>) {
      return items;
    } else if(items is Map<dynamic,dynamic>) {

      Map<String,T> newItems = {};
      items.forEach((i, value) {
        Caster cast = Caster(i);
        newItems[cast.toString()] = value;
      });
      return newItems;
    } else if(items is List) {
      Map<String,T> newItems = {};
      items.asMap().forEach((i, value) {
        newItems[i.toString()] = value;
      });
      return newItems;
    } else if(C.isScalar(items)) {


      Map<String,T> newItems = {};
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
  operator []=(dynamic key, dynamic value)  {
    String keyString = Caster(key).toString();
    _items[keyString]=value;

  }

  dynamic get(String key,{defaultValue}) {
    return Arr.get(_items,key,defaultValue:defaultValue);

  }

  Collection setItems(Map map) {
    _items = map;
    return this;
  }

  @override
  String toString() {
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