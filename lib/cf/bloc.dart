


import 'package:rxdart/rxdart.dart';

import 'bloc/bloc_builder.dart';
import 'bloc/bloc_result.dart';
import 'bloc/bloc_state.dart';

class CFBloc<E> {


  var actionController = PublishSubject<CFBlocState>();
  Stream<CFBlocState> get stream => actionController.stream;

  CFBlocResult<E> result = CFBlocResult<E>();
  bool _isDispatching = false;
  String state;
  bool asyncDispatching = false;



  get isDispatching => _isDispatching;
  void setValue(E t,{String state}) {
    result.setValue(t);
    CFBlocState<E> mageState = CFBlocState<E>(state,result);
    this.state = state;
    actionController.sink.add(mageState);
  }



  bool dispatch(Function callback) {
    if(!asyncDispatching && isDispatching) {
      return false;
    }

    _isDispatching=true;
    Stream stateString = callback(result);

    stateString.listen((item) {
      this.state=item;
      CFBlocState<E> state = CFBlocState<E>(item,result);
      actionController.sink.add(state);
    },onDone: () {
      _isDispatching=false;
    });
    return true;
  }

  CFBlocBuilder createBuilder(Function callback) {
    return CFBlocBuilder(
      stream: actionController.stream,
      builder: callback,
    );

  }




}