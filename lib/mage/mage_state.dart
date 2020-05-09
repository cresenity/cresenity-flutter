

import 'mage_result.dart';

class MageState<T> {
  String state;
  MageResult<T> result;

  MageState(String state, MageResult<T> result) {
    this.state = state;
    this.result = result;
  }

}