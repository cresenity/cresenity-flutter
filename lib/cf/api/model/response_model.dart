


import 'dart:convert';

import 'package:cresenity/helper/arr.dart';
import 'package:cresenity/cf/api/model/abstract_data_model.dart';
import 'package:cresenity/cf/api/model/data/list_data_model.dart';

class ResponseModel<T> {
  int errCode;
  String errMessage;

  T data;

  /// Add factory functions for every Type and every constructor you want to make available to `make`
  static Map<Type, Function> factories =  {
    ListDataModel: (Map map) => ListDataModel.fromMap(map)
  };

  static registerFactory(Type t,Function f) {
    factories[t]=f;
  }

  ResponseModel.fromJson(String json) {
    Map item = jsonDecode(json);
    errCode = Arr.getInt(item,'errCode');
    errMessage = Arr.getString(item,'errMessage');

    data = factories[T](Arr.getMap(item,'data'));

  }

  bool isError() {
    return errCode>0 ? true:false;
  }
}

