


import '../../../../helper/media.dart';
import '../helper/parser.dart';

class ValueUnit {

  double value;
  String unit;

  ValueUnit(this.value,[this.unit='']);


  factory ValueUnit.parse(String str) {
    return Parser.parseValueUnit(str);
  }

  factory ValueUnit.empty() {
    return ValueUnit(0,'px');
  }

  String toString() {
    return "$value $unit";
  }


  double getValue([double parentValue]) {
    if(unit=='px') {
      return value;
    }
    if(parentValue==null) {
      parentValue = Media.screenWidth;
    }
    if(unit=='%') {
      return parentValue * value / 100;
    }
    return value;
  }

}