


import 'package:flutter/material.dart';
import 'package:cresenity/cf.dart';
import 'package:cresenity/ui/basic/basic_scaffold.dart';


abstract class CFPage extends StatefulWidget{
  String title;
  CFPageState currentState;
  CFPage({Key key, this.title}) : super(key: key);


  @override
  State<CFPage> createState() {
    currentState= CFPageState();
    CF.app().addState(currentState);

    return currentState;

  }


  Widget build(BuildContext context);

  void initState() {

  }

  void setState(Function f) {
    if(currentState!=null) {
      currentState.publicSetState(f);
    }
  }

}

class CFPageState extends State<CFPage> {

  @override
  void initState() {
    super.initState();
    widget.initState();
  }
  @override
  Widget build(BuildContext context) {
      return widget.build(context);
  }

  void publicSetState(VoidCallback fn) {
    setState(fn);
  }

}