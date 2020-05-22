

import 'storage/adapter.dart';
import 'storage/factory.dart';

class CFStorage {
  static const String ADAPTER_SHARED_PREFERENCES = 'sharedPreferences';
  static const String ADAPTER_HIVE = 'hive';
  static const String DEFAULT_ADAPTER = ADAPTER_HIVE;

  CFStorage._({String adapter = DEFAULT_ADAPTER}) {

    _adapter = Factory.createAdapter(adapter);
  }

  static  Map<String,CFStorage> _instance;

  String _adapterType = ADAPTER_SHARED_PREFERENCES;
  factory CFStorage({String adapter}) {
    if(adapter==null) {
      adapter=DEFAULT_ADAPTER;
    }


    if(_instance==null) {
      _instance = Map<String,CFStorage>();
    }
    if(!_instance.containsKey(adapter)) {
      _instance[adapter] = CFStorage._();
    }

    return _instance[adapter];
  }

  Adapter _adapter;
  get adapterType => _adapterType;


  void setAdapterType(String type) {
    this._adapterType = type;
  }

  void setup() async {

    _adapter.setup();
  }



  String get(String key,{String defaultValue}) {
    return _adapter.get(key,defaultValue: defaultValue);
  }

  void put(String key,String value) async {
    await _adapter.put(key,value);
  }

  void unset(String key) async {
    await _adapter.unset(key);
  }

  Future<bool> putWait(String key,String value) {
    return _adapter.put(key,value);
  }

}