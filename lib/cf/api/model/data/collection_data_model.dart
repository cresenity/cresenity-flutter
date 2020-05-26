




import '../../../../support/collection.dart';
import '../abstract_data_model.dart';

class CollectionDataModel extends Collection implements AbstractDataModel {
  CollectionDataModel([items]): super(items);

  CollectionDataModel.fromJson(Map map) {
    setItems(map);

  }
  
  
  @override
  Map<String, dynamic > toJson() => all();

}