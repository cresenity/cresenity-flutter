

import '../bloc.dart';
import 'bloc_result.dart';

class CFBlocState<T> {
  String state;
  CFBlocResult<T> result;
  CFBloc bloc;

  CFBlocState(String state, CFBlocResult<T> result, CFBloc bloc) {
    this.state = state;
    this.result = result;
    this.bloc = bloc;
  }

}