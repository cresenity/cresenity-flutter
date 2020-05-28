




import 'package:flutter/material.dart';

import '../helper/parser.dart';
import 'value_unit.dart';


class ValueBorder {

  ValueUnit valueUnit;
  BorderStyle style;
  Color color;


  ValueBorder(this.valueUnit,[this.style=BorderStyle.none, this.color = Colors.transparent ]) {
      if(style==null) {
        style=BorderStyle.none;
      }
      if(color==null) {
        color = Colors.transparent;
      }
  }


  factory ValueBorder.parse(String str) {

    return Parser.valueBorderParser(str);
  }

  factory ValueBorder.empty() {
    return ValueBorder(ValueUnit.empty());
  }

  String toString() {
    return "$valueUnit $style ${Parser.ColortoHexString(color)}";
  }


}