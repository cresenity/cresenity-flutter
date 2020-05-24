




import 'package:flutter/material.dart';

import '../element.dart';
import 'base.dart';

class CFUIElementDiv extends CFUIElementBase {

  final String name="Div";
  CFUIElementDiv() {

  }

  _widgetWrap() {
    return Wrap(
      direction: styles.getAxis(),
      alignment: styles.getWrapAlignment(),
      crossAxisAlignment: styles.getWrapCrossAlignment(),

      children: childrenWidget(),
    );
  }
  _widgetFlex() {
    return Flex(
      direction: styles.getAxis(),
      mainAxisAlignment: styles.getMainAxisAlignment(),
      crossAxisAlignment: styles.getCrossAxisAlignment(),

      children: childrenWidget(),
    );
  }

  Widget toWidget() {

    return getWrapper(child:_widgetWrap());
  }


}