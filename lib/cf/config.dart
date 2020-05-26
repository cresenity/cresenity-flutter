
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../support/collection.dart';
import 'config/default_config.dart';

class CFConfig {

  Collection _configMap;

  static final CFConfig _instance = new CFConfig._();

  factory CFConfig() {
    return _instance;
  }



  CFConfig._() {
    _configMap =Collection();
  }


  setup({Map configMap})  {

    loadDefaultConfig();
    if(configMap!=null) {
      _configMap = _configMap.merge(Collection(items: configMap));
    }
  }

  loadDefaultConfig() {


    _configMap = Collection(items:CFUIDefaultConfig.config);
  }



  get(String key, defaultValue) {
    return _configMap.get(key,defaultValue);
  }


}
