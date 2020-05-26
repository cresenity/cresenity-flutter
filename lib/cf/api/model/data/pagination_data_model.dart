

import 'package:cresenity/cf/api/model/abstract_data_model.dart';
import 'package:cresenity/support/array.dart';
import 'package:cresenity/helper/arr.dart';

import '../../../../support/collection.dart';
class PaginationDataModel extends AbstractDataModel {
  int total =0;
  int lastPage =0;
  int perPage =10;
  int currentPage =1;
  Array items;

  PaginationDataModel() {
    reset();
  }

  PaginationDataModel.fromJson(Map map) {
    total = Arr.getInt(map, "total");
    lastPage = Arr.getInt(map, "lastPage");
    perPage = Arr.getInt(map, "perPage");
    currentPage = Arr.getInt(map, "currentPage");
    items = Arr.getArray(map, "items");

  }



  void reset() {
    currentPage=0;
    items = Array();
  }

  updateFromModel(PaginationDataModel model) {
    total = model.total;
    lastPage = model.lastPage;
    perPage = model.perPage;
    currentPage = model.currentPage;
    items.merge(model.items);
  }

  updateFromJson(Map map) {
    total = Arr.getInt(map, "total");
    lastPage = Arr.getInt(map, "lastPage");
    perPage = Arr.getInt(map, "perPage");
    currentPage = Arr.getInt(map, "currentPage");
    items.merge(Arr.getArray(map, "items"));
  }


  int remainPage() {
    return lastPage-currentPage;
  }

  @override
  Map<String, dynamic > toJson() => {
    "total":total,
    "lastPage":lastPage,
    "perPage":perPage,
    "currentPage":currentPage,
    "items":Collection(items).all(),
  };
}