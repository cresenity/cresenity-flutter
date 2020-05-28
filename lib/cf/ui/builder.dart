


import 'builder/element.dart';
import 'builder/element/div.dart';

class CFUIBuilder {

  static final CFUIBuilder _instance = new CFUIBuilder._();

  factory CFUIBuilder() {
    return _instance;
  }

  CFUIBuilder._();

  CFUIElement createDiv() {
    return CFUIElementDiv();
  }





}