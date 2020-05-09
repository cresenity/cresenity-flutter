


import 'package:flutter/material.dart';
import 'package:cresenity/cf.dart';
import 'package:cresenity/ui/basic/basic_scaffold.dart';


abstract class CFPage extends StatefulWidget{
  String title;
  CFPage({Key key, this.title}) : super(key: key);


  @override
  State<CFPage> createState() {
    State s = CFPageState();
    CF.app().addState(s);

    return s;

  }


  Widget build(BuildContext context);

  void initState() {

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