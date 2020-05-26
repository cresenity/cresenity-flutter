


import 'package:flutter/material.dart';

import '../../../../cf.dart';
import '../../../../helper/arr.dart';
import '../../../../support/caster.dart';
import '../styles.dart';
import '../support/value_border.dart';
import '../support/value_trbl.dart';
import '../support/value_unit.dart';

class Parser {
  static ValueUnit parseValueUnit(String cssValue, {bool parseFloatToInt = false}) {
    if(cssValue==null) {
      return null;
    }
    final RegExp unitRegex = new RegExp(r'[\d.,]*(\D*)', multiLine: true);


    String widthUnit = '';

    var matches = unitRegex.allMatches(cssValue);
    if(matches.length>0) {
      var match = matches.elementAt(0);
      widthUnit = match.group(1);
    }

    double parsedWidth = retrieveDouble(cssValue,defaultValue: 0);


    parsedWidth = parseFloatToInt ? parsedWidth.floor():parsedWidth;

    if(widthUnit==null || widthUnit!='%') {
      widthUnit='px';
    }
    return ValueUnit(parsedWidth,widthUnit);

  }

  static retrieveDouble(String str, {double defaultValue}) {
    final intRegex = RegExp(r'(\d+)', multiLine: true);
    final doubleRegex = RegExp(r'\s+(\d+\.\d+)\s+', multiLine: true);

    double parsedDouble = defaultValue;
    var matches = intRegex.allMatches(str);

    if(matches.length>0) {
      var match = matches.elementAt(0);

      parsedDouble = Caster(match.group(1)).toDouble();
    }
    matches = doubleRegex.allMatches(str);
    if(matches.length>0) {
      var match = matches.elementAt(0);
      parsedDouble = Caster(match.group(1)).toDouble();
    }

    return parsedDouble;
  }


  static ValueTRBL valueTRBLParser(String cssValue) {
    if(cssValue==null) {
      return null;
    }


    ValueUnit top = ValueUnit.parse(shorthandParser(cssValue, 'top'));
    ValueUnit bottom = ValueUnit.parse(shorthandParser(cssValue, 'bottom'));
    ValueUnit left = ValueUnit.parse(shorthandParser(cssValue, 'left'));
    ValueUnit right = ValueUnit.parse(shorthandParser(cssValue, 'right'));


    return ValueTRBL(top:top,right:right,left:left ,bottom: bottom);

  }

  static shorthandParser(String cssValue, String direction) {
    List splittedCssValue = cssValue.split(' ');
    Map<String,int> directions = {};
    switch (splittedCssValue.length) {
      case 2:
        directions = {'top' : 0, 'bottom' : 0, 'left' : 1, 'right' : 1};
      break;
      case 3:
        directions = {'top' : 0, 'bottom' : 0, 'left' : 1, 'right' : 2};
      break;
      case 4:
        directions = {'top' : 0, 'bottom' : 1, 'left' : 2, 'right' : 3};
      break;
      case 1:
      default:
        return cssValue;
    }
    return Arr.get(splittedCssValue, directions[direction], defaultValue: '0');
  }


  static ValueBorder valueBorderParser(String cssValue) {
    if(cssValue==null) {
      return null;
    }
    List splittedCssValue = cssValue.split(' ');
    ValueUnit valueUnit;
    BorderStyle style;
    Color color;

    if(splittedCssValue.length>0) {
      valueUnit = ValueUnit.parse(splittedCssValue[0]);
    }

    if(splittedCssValue.length>1) {
      style = parseBorderStyle(splittedCssValue[1]);
    }
    if(splittedCssValue.length>2) {
      color = parseColor(splittedCssValue[2]);
    }
    return ValueBorder(valueUnit,style,color);
  }

  static BorderStyle parseBorderStyle(String cssValue) {

    if(cssValue!=null) {
      if(cssValue.trim().toLowerCase()=='solid') {
        return BorderStyle.solid;
      }
    }
    return BorderStyle.none;

  }
  static Color parseColor(String cssValue) {
    if(cssValue == null) {
      return null;
    }
    final buffer = StringBuffer();
    if (cssValue.length == 6 || cssValue.length == 7) buffer.write('ff');
    buffer.write(cssValue.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }




  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  static String ColortoHexString(Color color, {bool leadingHashSign = true}) {
      return '${leadingHashSign ? '#' : ''}'
      '${color.alpha.toRadixString(16).padLeft(2, '0')}'
      '${color.red.toRadixString(16).padLeft(2, '0')}'
      '${color.green.toRadixString(16).padLeft(2, '0')}'
      '${color.blue.toRadixString(16).padLeft(2, '0')}';
  }


  static FontWeight parseFontWeight(String cssValue) {
    if(cssValue==null) {
      return null;
    }
    switch(cssValue.trim().toLowerCase()) {
      case 'bold':
        return FontWeight.bold;
      case '100':
         return FontWeight.w100;
      case '200':
        return FontWeight.w200;
      case '300':
        return FontWeight.w300;
      case '400':
        return FontWeight.w400;
      case '500':
        return FontWeight.w500;
      case '600':
        return FontWeight.w600;
      case '700':
        return FontWeight.w700;
      case '800':
        return FontWeight.w800;
      case '900':
        return FontWeight.w900;



    }
    return FontWeight.normal;
  }

  static Axis parseAxis(String cssValue) {
    if(cssValue==null) {
      return null;
    }
    switch(cssValue.trim().toLowerCase()) {
      case 'row':
        return Axis.horizontal;
      case 'column':
        return Axis.vertical;
    }
    return Axis.vertical;

  }

  static CrossAxisAlignment parseCrossAxisAlignment(String cssValue) {
    if(cssValue==null) {
      return null;
    }
    switch(cssValue.trim().toLowerCase()) {
      case 'flex-start':
        return CrossAxisAlignment.start;
      case 'flex-end':
        return CrossAxisAlignment.end;
      case 'center':
        return CrossAxisAlignment.center;
      case 'stretch':
        return CrossAxisAlignment.stretch;
      case 'initial':
        return CrossAxisAlignment.baseline;
    }
    return CrossAxisAlignment.start;

  }

  static MainAxisAlignment parseMainAxisAlignment(String cssValue) {
    if(cssValue==null) {
      return null;
    }
    switch(cssValue.trim().toLowerCase()) {
      case 'flex-start':
        return MainAxisAlignment.start;
      case 'flex-end':
        return MainAxisAlignment.end;
      case 'center':
        return MainAxisAlignment.center;
      case 'space-between':
        return MainAxisAlignment.spaceBetween;
      case 'space-evenly':
        return MainAxisAlignment.spaceEvenly;
      case 'space-around':
        return MainAxisAlignment.spaceAround;

    }
    return MainAxisAlignment.start;

  }

  static WrapAlignment parseWrapAlignment(String cssValue) {
    if(cssValue==null) {
      return null;
    }
    switch(cssValue.trim().toLowerCase()) {
      case 'flex-start':
        return WrapAlignment.start;
      case 'flex-end':
        return WrapAlignment.end;
      case 'center':
        return WrapAlignment.center;
      case 'space-between':
        return WrapAlignment.spaceBetween;
      case 'space-evenly':
        return WrapAlignment.spaceEvenly;
      case 'space-around':
        return WrapAlignment.spaceAround;

    }
    return WrapAlignment.start;

  }

  static WrapCrossAlignment parseWrapCrossAlignment(String cssValue) {
    if(cssValue==null) {
      return null;
    }
    switch(cssValue.trim().toLowerCase()) {
      case 'flex-start':
      case 'start':
        return WrapCrossAlignment.start;
      case 'flex-end':
      case 'end':
        return WrapCrossAlignment.end;
      case 'center':
        return WrapCrossAlignment.center;

    }
    return WrapCrossAlignment.start;

  }

  static DisplayType parseDisplayType(String cssValue) {
    if(cssValue==null) {
      return null;
    }
    switch(cssValue.trim().toLowerCase()) {
      case 'block':
        return DisplayType.block;
      case 'flex':
        return DisplayType.flex;
      case 'inline':
        return DisplayType.inline;


    }
    return DisplayType.block;

  }

  static TextAlign parseTextAlign(String cssValue) {
    if(cssValue==null) {
      return null;
    }
    switch(cssValue.trim().toLowerCase()) {
      case 'left':
      case 'start':
        return TextAlign.start;
      case 'right':
      case 'end':
        return TextAlign.end;
      case 'center':
        return TextAlign.center;
      case 'justify':
        return TextAlign.justify;


    }
    return TextAlign.start;
  }

}