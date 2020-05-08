


import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cresenity/cf.dart';
import 'package:cresenity/ui/basic/basic_scaffold.dart';


abstract class CFPage extends StatefulWidget{

  Widget bottomNav;
  CFPage({this.bottomNav});

  @override
  State<CFPage> createState() {
    State s = CFPageState();
    CF.app().addState(s);

    return s;

  }

  @protected
  Widget build();

  @protected
  Widget buildBottomNav() {
    return bottomNav;
  }

}

class CFPageState extends State<CFPage> {

  @override
  void initState() {



    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
        bodyData: widget.build(),
        bottomNav: widget.buildBottomNav(),
    );

  }



  void publicSetState(VoidCallback fn) {
    setState(fn);
  }

}