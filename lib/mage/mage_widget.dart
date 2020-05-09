import 'dart:async';
import 'package:flutter/material.dart';


import 'package:cresenity/mage/mage.dart';

class MageWidget extends StatefulWidget {
  MageWidget({
    Key key,
    @required this.child,
    @required this.mage,
  }): super(key: key);

  final Widget child;
  final Mage mage;


  @override
  _MageWidgetState createState() => _MageWidgetState();



  static Mage of(BuildContext context){
    _MageWidgetInherited provider = context.getElementForInheritedWidgetOfExactType().widget;
    return provider?.mage;
  }
}



class _MageWidgetState extends State<MageWidget>{
  @override
  void dispose(){
    //widget.mage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

      return new _MageWidgetInherited(
      mage: widget.mage,
      child: widget.child,
    );
  }
}



class _MageWidgetInherited extends InheritedWidget {
  _MageWidgetInherited({
    Key key,
    @required Widget child,
    @required this.mage,
  }) : super(key: key, child: child);

  final Mage mage;

  @override
  bool updateShouldNotify(_MageWidgetInherited oldWidget) => true;
}