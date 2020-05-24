


import 'element.dart';

enum ListenerType {
  click
}

class CFUIListener {
  Map<ListenerType,List<Function>> _listener = Map<ListenerType,List<Function>>();

  CFUIElement element;
  CFUIListener(this.element);
  add(ListenerType type, Function f) {
    if(!_listener.containsKey(type)) {
      _listener[type] = [];
    }
    _listener[type].add(f);
  }

  have(ListenerType type) {
    return _listener.containsKey(type);
  }

  run(ListenerType type) {
    if(have(type)) {
      _listener[type].forEach((f){
        f();
      });
    }
  }

}