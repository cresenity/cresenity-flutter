import 'package:flutter/material.dart';

import '../../../cf.dart';
import '../../../helper/str.dart';
import 'element/div.dart';
import 'element/text.dart';
import 'listener.dart';
import 'styles.dart';

abstract class CFUIElement {

  final String name="Element";

  CFUIStyles _styles;
  CFUIListener _listeners;

  CFUIElement() {
    _styles = CFUIStyles(this);
    _listeners = CFUIListener(this);
  }

  List<CFUIElement> children = List<CFUIElement>();
  CFUIElement _parent;

  CFUIElementDiv addDiv({Map<String,String> styles}) {
    CFUIElementDiv div = CFUIElementDiv();
    _addElement(div,styles: styles);
    return div;
  }


  CFUIElement add(element,{Map<String,String> styles}) {
    return _addElement(element,styles: styles);
  }

  CFUIElement _addElement(element, {Map<String,String> styles}) {


    if(element is String) {
      element = CFUIElementText(element);

    }


    if(element is CFUIElement) {
      element.setParent(this);
      children.add(element);
      if(styles!=null) {
        element.setStyles(styles);
      }
    }


    return element;
  }

  setParent(element) {
    _parent=element;
    return this;
  }

  List<Widget> childrenWidget() {
    List<Widget> list = [];
    children.forEach((item){
      list.add(item.toWidget());
    });
    return list;
  }

  Widget toWidget();





  setStyles(Map<String,String> styles) {
    styles.forEach((key,value){
      setStyle(key,value);
    });
    return this;
  }

  setStyle(String key, String value) {
    _styles.set(key,value);
    return this;
  }



  Widget get widget => toWidget();

  CFUIStyles get styles =>_styles;
  CFUIListener get listeners => _listeners;

  void onClick(Function onClick) {
    _listeners.add(ListenerType.click,onClick);
  }


  String printTree({int level=0}) {
    String indent = Str.repeat("  ", level);


    StringBuffer sb = StringBuffer();
    sb.writeln('${indent}<${name.toLowerCase()} style="${_styles.toString()}">');


    children.forEach((item){
      sb.write(item.printTree(level:level+1));
    });
    sb.writeln('${indent}</${name.toLowerCase()}>');


    return sb.toString();
  }

  String computedString({int level=0}) {
    String indent = Str.repeat("  ", level);


    StringBuffer sb = StringBuffer();
    sb.writeln('${indent}<${name.toLowerCase()} style="${_styles.computedString()}">');


    children.forEach((item){
      sb.write(item.computedString(level:level+1));
    });
    sb.writeln('${indent}</${name.toLowerCase()}>');


    return sb.toString();
  }

  String toString() {
    return printTree();
  }


  bool isRoot() {
    return parent == null;
  }


  double get width => _styles.getWidth();
  double get parentWidth => _parent?.styles?.getWidth();
  CFUIElement get parent => _parent;
}