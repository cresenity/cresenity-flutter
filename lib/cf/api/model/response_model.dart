


import 'dart:convert';

import 'package:cresenity/helper/arr.dart';
import 'package:cresenity/cf/api/model/data/pagination_data_model.dart';
import 'package:cresenity/support/collection.dart';

import '../../../cf.dart';
import 'abstract_data_model.dart';
import 'abstract_model.dart';
import 'data/collection_data_model.dart';

class ResponseModel<T extends AbstractDataModel> implements AbstractModel {
  int errCode;
  String errMessage;

  T data;

  /// Add factory functions for every Type and every constructor you want to make available to `make`
  static Map<Type, Function> factories =  {
    PaginationDataModel: (Map map) => PaginationDataModel.fromJson(map),
    CollectionDataModel: (Map map) => CollectionDataModel(items:map),
    AbstractDataModel: (Map map) => CollectionDataModel(items:map),
    dynamic: (Map map) => CollectionDataModel(items:map),
  };

  static registerFactory(Type t,Function f) {
    factories[t]=f;
  }

  ResponseModel.fromJson(String json) {
    Map item = jsonDecode(json);
    errCode = Arr.getInt(item,'errCode');
    errMessage = Arr.getString(item,'errMessage');

    if(factories.containsKey(T)) {
      data = factories[T](Arr.getMap(item, 'data'));
    } else {
      data = CollectionDataModel(items:Arr.getMap(item, 'data')) as T;
    }

  }

  bool isError() {
    return errCode>0 ? true:false;
  }

  @override
  Map<String, dynamic> toJson() => {
      'errCode':errCode,
      'errMessage':errMessage,
      'data':data.toJson(),
  };
}

