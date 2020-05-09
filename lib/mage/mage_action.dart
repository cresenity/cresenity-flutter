import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'mage_builder.dart';
import 'mage_event.dart';
import 'mage_result.dart';
import 'mage_state.dart';



class MageAction<E> {

  var actionController = PublishSubject<MageState>();
  Stream<MageState> get stream => actionController.stream;

  MageResult<E> result = MageResult<E>();
  bool _isDispatching = false;
  String state;
  bool asyncDispatching = false;



  get isDispatching => _isDispatching;
  void setValue(E t,{String state}) {
    result.setValue(t);
    MageState<E> mageState = MageState<E>(state,result);
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
      MageState<E> state = MageState<E>(item,result);
      actionController.sink.add(state);
    },onDone: () {
      _isDispatching=false;
    });
    return true;
  }

  MageBuilder createBuilder(Function callback) {
    return MageBuilder(
      stream: actionController.stream,
      builder: callback,
    );

  }




}