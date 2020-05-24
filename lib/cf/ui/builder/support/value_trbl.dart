


import '../helper/parser.dart';
import 'value_unit.dart';

class ValueTRBL {
  ValueUnit top;
  ValueUnit right;
  ValueUnit bottom;
  ValueUnit left;

  ValueTRBL({this.top,this.right,this.left,this.bottom}) {
    top = top ?? ValueUnit.empty();
    right = right ?? ValueUnit.empty();
    left = left ?? ValueUnit.empty();
    bottom = bottom ?? ValueUnit.empty();

  }

  factory ValueTRBL.parse(String str) {
    return Parser.valueTRBLParser(str);
  }

  factory ValueTRBL.empty() {
    return ValueTRBL();
  }

  String toString() {
    return "$top $right $left $right";
  }
}