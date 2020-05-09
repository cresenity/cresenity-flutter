library cresenity.mage;
import 'package:rxdart/rxdart.dart';

import 'mage_action.dart';

class Mage {

  var actionMap = Map<String,MageAction>();


  MageAction<T> createAction<T>(String actionName) {
    MageAction<T> action = new MageAction<T>();

    actionMap[actionName]=action;
    return action;
  }


}