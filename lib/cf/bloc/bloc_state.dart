

import 'bloc_result.dart';

class CFBlocState<T> {
  String state;
  CFBlocResult<T> result;

  CFBlocState(String state, CFBlocResult<T> result) {
    this.state = state;
    this.result = result;
  }

}