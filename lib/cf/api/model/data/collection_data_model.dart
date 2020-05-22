




import '../../../../support/collection.dart';
import '../abstract_data_model.dart';

class CollectionDataModel extends Collection implements AbstractDataModel {
  CollectionDataModel({items}): super(items:items);


  @override
  Map<String, dynamic > toJson() => all();

}