


import '../helper/arr.dart';
import '../helper/c.dart';
import 'caster.dart';

class Array {
  List<dynamic> _items;

  List<dynamic> all() {
    return _items;
  }

  Array( {Object items}) {
    _items = _getListableItems(items);
    if(_items==null) {
      clear();
    }
  }


  Array clear() {
    _items = List<dynamic>();
  }


  _getListableItems(Object items) {
    if(items==null) {
      return List<dynamic>();
    }
    if (items is Array) {
      return items.all();
    } else if(items is List) {
      return items;
    } else if(items is Map) {
      return items.values;

    } else if(C.isScalar(items)) {


      List<dynamic> newItems = [];
      newItems.add(items);
      return newItems;
    }

    return List<dynamic>();



  }


  operator [](int key)  {
    return get(key);
  }

  dynamic get(int key,{defaultValue}) {
      return Arr.get(_items,key,defaultValue: defaultValue);
  }


  int count() {
    return _items.length;
  }

  get length => count();

  Array merge(Array other) {
    _items.addAll(other.all());
    return this;

  }

}