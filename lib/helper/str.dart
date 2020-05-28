


import 'package:intl/intl.dart';

import '../support/array.dart';
import '../support/caster.dart';

class Str {


  static String toUpper(String str) {
    return str.toUpperCase();
  }
  static String toLower(String str) {
    return str.toLowerCase();
  }

  static String repeat(String str, int multiplier) {
    String newString = '';
    for(int i=0; i<multiplier;i++) {
      newString+=str;
    }
    return newString;
  }

  static String numberFormat(Object param, {int decimals = 0, String decimalPoint = ".", String thousandSeparator = ","}) {
    int number = Caster(param).toInt();
    String format = "#" + thousandSeparator + '##0';
    if(decimals>0) {
      format += decimalPoint+ repeat('0', decimals);
    }
    final formatter = new NumberFormat(format);
    return formatter.format(number);

  }

  static Array explode(String delimiter,String str) {
    return Array(str.split(new RegExp(r''+delimiter+'')));
  }

}