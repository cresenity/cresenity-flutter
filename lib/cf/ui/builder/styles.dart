


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../cf.dart';
import '../../../helper/media.dart';
import '../../../support/collection.dart';
import 'element.dart';
import 'helper/parser.dart';
import 'support/value_trbl.dart';
import 'support/value_unit.dart';
import 'support/value_border.dart';

enum DisplayType {
  flex, block,inline
}

enum FlexWrapType {
  noWrap, flexWrap, wrapReverse
}


class CFUIStyles {

  Collection _styles = Collection();
  CFUIElement element;
  CFUIStyles(this.element);


  set(String key, String style) {
    _styles[key]=style;
    return this;
  }

  get(String key, {String defaultValue}) {
    return _styles.get(key,defaultValue: defaultValue);
  }

  Collection get styles => _styles;

  String toString() {
    StringBuffer sb = StringBuffer();
    _styles.forEach((name,value){
      sb.write("${name}:${value};");
    });
    return sb.toString();
  }

  String computedString() {
    StringBuffer sb = StringBuffer();
    sb.write("width:${getWidth()}");
    return sb.toString();
  }



  EdgeInsets getMargin() {


    ValueTRBL margin = ValueTRBL.parse(get("margin"));
    ValueUnit marginLeft = ValueUnit.parse(get("margin-left"));
    ValueUnit marginRight = ValueUnit.parse(get("margin-right"));
    ValueUnit marginTop = ValueUnit.parse(get("margin-top"));
    ValueUnit marginBottom = ValueUnit.parse(get("margin-bottom"));


    return EdgeInsets.only(
      top: marginTop?.value ?? margin?.top?.value?? 0,
      right: marginRight?.value ?? margin?.right?.value?? 0,
      bottom: marginBottom?.value ?? margin?.bottom?.value?? 0,
      left: marginLeft?.value ?? margin?.left?.value ?? 0,

    );
  }

  EdgeInsets getPadding() {


    ValueTRBL padding = ValueTRBL.parse(get("padding"));
    ValueUnit paddingLeft = ValueUnit.parse(get("padding-left"));
    ValueUnit paddingRight = ValueUnit.parse(get("padding-right"));
    ValueUnit paddingTop = ValueUnit.parse(get("padding-top"));
    ValueUnit paddingBottom = ValueUnit.parse(get("padding-bottom"));


    return EdgeInsets.only(
      top: paddingTop?.value ?? padding?.top?.value?? 0,
      right: paddingRight?.value ?? padding?.right?.value?? 0,
      bottom: paddingBottom?.value ?? padding?.bottom?.value?? 0,
      left: paddingLeft?.value ?? padding?.left?.value ?? 0,

    );
  }

  double getOuterWidth() {
    if(element.isRoot()) {
      return Media.screenWidth;
    }
    ValueUnit widthUnit = ValueUnit.parse(get("width"));
    double width = element?.parent?.styles?.getInnerWidth() ?? null;
    return width;
  }

  double getContentWidth() {
    ValueUnit widthUnit = ValueUnit.parse(get("width"));
    double width = widthUnit?.getValue(getOuterWidth()) ?? getOuterWidth();
    EdgeInsets margin = getMargin();
    width-=margin.left;
    width-=margin.right;


    return width;
  }
  double getMinWidth() {
    ValueUnit widthUnit = ValueUnit.parse(get("min-width"));
    double width = widthUnit?.getValue(getContentWidth()) ?? 0;
    return width;
  }

  double getMaxWidth() {
    ValueUnit widthUnit = ValueUnit.parse(get("max-width"));
    double width = widthUnit?.getValue(getContentWidth()) ?? Media.screenWidth;
    return width;
  }

  double getWidth() {

    DisplayType parentDisplay = element?.parent?.styles?.getDisplayType() ?? DisplayType.block;
    DisplayType display = getDisplayType();
    if(parentDisplay==DisplayType.flex) {

      return null;

    }
    if(display==DisplayType.inline) {
      return null;
    }

    double width =  getContentWidth();

    return width;
  }

  double getInnerWidth() {
    double width = getContentWidth();
    EdgeInsets padding = getPadding();
    width-=padding.left;
    width-=padding.right;
    return width;
  }

  double getHeight() {
    ValueUnit heightUnit = ValueUnit.parse(get("height"));
    double height = heightUnit?.value ?? null;
    return height;
  }


  Border getBorder() {
    ValueBorder border = ValueBorder.parse(get("border"));
    ValueBorder borderLeft = ValueBorder.parse(get("border-left"));
    ValueBorder borderRight = ValueBorder.parse(get("border-right"));
    ValueBorder borderTop = ValueBorder.parse(get("border-top"));
    ValueBorder borderBottom = ValueBorder.parse(get("border-bottom"));



    Border borderResult =  Border(
      top: BorderSide(
        width: borderTop?.valueUnit?.value ?? border?.valueUnit?.value ?? 0,
        style: borderTop?.style ?? border?.style ?? BorderStyle.solid,
        color: borderTop?.color ?? border?.color ?? Colors.transparent,
      ),
      right: BorderSide(
        width: borderRight?.valueUnit?.value ?? border?.valueUnit?.value ?? 0,
        style: borderRight?.style ?? border?.style ?? BorderStyle.solid,
        color: borderRight?.color ?? border?.color ?? Colors.transparent,
      ),
      bottom: BorderSide(
        width: borderBottom?.valueUnit?.value ?? border?.valueUnit?.value ?? 0,
        style: borderBottom?.style ?? border?.style ?? BorderStyle.solid,
        color: borderBottom?.color ?? border?.color ?? Colors.transparent,
      ),
      left: BorderSide(
        width: borderLeft?.valueUnit?.value ?? border?.valueUnit?.value ?? 0,
        style: borderLeft?.style ?? border?.style ?? BorderStyle.solid,
        color: borderLeft?.color ?? border?.color ?? Colors.transparent,
      ),
    );

    return borderResult;
  }


  Color getBackgroundColor() {
    Color background = Parser.parseColor(get('background'));
    Color backgroundColor = Parser.parseColor(get('background-color'));

    return backgroundColor ?? background ?? Colors.transparent;
  }

  BorderRadius getBorderRadius() {
    ValueUnit borderRadius = ValueUnit.parse(get("border-radius"));
    ValueUnit borderRadiusTopLeft = ValueUnit.parse(get("border-top-left-radius"));
    ValueUnit borderRadiusTopRight = ValueUnit.parse(get("border-top-right-radius"));
    ValueUnit borderRadiusBottomLeft = ValueUnit.parse(get("border-bottom-left-radius"));
    ValueUnit borderRadiusBottomRight = ValueUnit.parse(get("border-bottom-right-radius"));

    double topLeftValue = borderRadiusTopLeft?.value ?? borderRadius?.value ?? 0;
    double topRightValue = borderRadiusTopRight?.value ?? borderRadius?.value ?? 0;
    double bottomLeftValue = borderRadiusBottomLeft?.value ?? borderRadius?.value ?? 0;
    double bottomRightValue = borderRadiusBottomRight?.value ?? borderRadius?.value ?? 0;

    Border border = getBorder();

    bool uniformedBorder = border.top == border.right &&
        border.right == border.left &&
        border.left == border.bottom;



    return uniformedBorder?BorderRadius.only(
      topLeft: Radius.circular(topLeftValue),
      topRight: Radius.circular(topRightValue),
      bottomLeft: Radius.circular(bottomLeftValue),
      bottomRight: Radius.circular(bottomRightValue),

    ):null;
  }

  Color getColor() {
    Color color = Parser.parseColor(get('color'));

    return color ?? element?.parent?.styles?.getColor() ?? Colors.black;
  }

  FontWeight getFontWeight() {
    FontWeight fontWeight = Parser.parseFontWeight(get('font-weight'));

    return fontWeight ?? element?.parent?.styles?.getFontWeight() ?? FontWeight.normal;
  }

  double getFontSize() {
    ValueUnit fontSize = Parser.parseValueUnit(get('font-size'));


    return fontSize?.value ?? element?.parent?.styles?.getFontSize() ?? 16;
  }

  TextAlign getTextAlign() {
    TextAlign textAlign = Parser.parseTextAlign(get('text-align'));


    return textAlign ?? element?.parent?.styles?.getTextAlign() ?? TextAlign.start;
  }

  Axis getAxis() {
    Axis axis = Parser.parseAxis(get('flex-direction'));
    return axis??Axis.vertical;
  }

  MainAxisAlignment getMainAxisAlignment() {

    MainAxisAlignment alignment = Parser.parseMainAxisAlignment(get('justify-content'));
    return alignment??MainAxisAlignment.start;
  }

  CrossAxisAlignment getCrossAxisAlignment() {

    CrossAxisAlignment alignment = Parser.parseCrossAxisAlignment(get('align-items'));
    return alignment??CrossAxisAlignment.start;
  }

  WrapAlignment getWrapAlignment() {

    WrapAlignment alignment = Parser.parseWrapAlignment(get('justify-content'));
    return alignment??WrapAlignment.start;
  }

  WrapCrossAlignment getWrapCrossAlignment() {

    WrapCrossAlignment alignment = Parser.parseWrapCrossAlignment(get('align-items'));
    return alignment??WrapCrossAlignment.start;
  }

  DisplayType getDisplayType() {
    return Parser.parseDisplayType(get('display'));
  }


  isRoot() {
    return element.isRoot();

  }
}