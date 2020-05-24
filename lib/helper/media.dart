

import 'package:flutter/material.dart';

import '../cf.dart';

class Media {



  static Size getScreenSize({BuildContext context}) {
    context = _determineContext(context);
    return MediaQuery.of(context).size;
  }

  static double getScreenWidth({BuildContext context}) {
    context = _determineContext(context);
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight({BuildContext context}) {
    context = _determineContext(context);
    return MediaQuery.of(context).size.height;
  }

  static _determineContext(BuildContext context) {
    if(context==null) {
      return CF.app.currentContext();
    }
    return context;
  }

  static Size get screenSize => getScreenSize();
  static double get screenWidth => getScreenWidth();
  static double get screenHeight => getScreenHeight();

}