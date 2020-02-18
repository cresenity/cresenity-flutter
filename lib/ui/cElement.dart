import 'package:flutter/cupertino.dart';
import '../utils.dart';

class CElement {
  Widget widget;
  String id;
  List<CElement> children;
  CElement() {
    id = Utils.uuid();

  }

  setWidget(Widget widget) {
    this.widget = widget;
    return this;
  }
  getWidget() {
    this.widget = widget;
    return this;
  }


  addContainer() {
    CElement element  = new CElement();
    element.setWidget(Container());
    this.children.add(element);
    return element;


  }


  Widget buildWidget() {
    this.children.forEach((e){
        if(e is Container) {

        }
    });
  }
}