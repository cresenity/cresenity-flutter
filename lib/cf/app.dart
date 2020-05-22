


import 'package:flutter/material.dart';

import 'package:cresenity/cf/page.dart';
import 'package:cresenity/show_dialog.dart';

import '../cf.dart';

class CFApp {
  static final CFApp _singleton = new CFApp._internal();

  factory CFApp() {
    return _singleton;
  }

  List<State<CFPage>> stateList;

  CFApp._internal() {
    stateList = new List();
  }


  CFPage createPage(CFPage page) {
    return page;
  }



  BuildContext currentContext() {
    return currentState()?.context;
  }

  CFPageState currentState() {
    if(currentPageIndex()<0) {
      return null;
    }
    return stateList[stateList.length-1];
  }

  CFPageState prevState() {
    if(stateList.length>1) {
      return stateList[stateList.length-2];
    }
    return null;
  }

  CFPage currentPage() {
    return currentState()?.widget;
  }
  String currentPageName() {
    return currentPage()?.runtimeType.toString();
  }

  CFPage prevPage() {
    CFPageState prevState = this.prevState();
    if(prevState!=null) {
      return prevState.widget;
    }
    return null;
  }

  void setState(VoidCallback fn) {
    currentState().publicSetState(fn);
  }

  CFApp addState(State state) {
    stateList.add(state);
    return this;
  }


  showDialog(message) {

    CF.logger().d(this.currentContext);
    ShowDialog dialog = ShowDialog(context:this.currentContext(),message:message);
    dialog.show();
  }
  pushPage(CFPage page) {

    Navigator.of(this.currentContext()).push(
      new MaterialPageRoute(builder: (context) => page),
    ).then((value) {
      stateList.removeLast();
      setState((){});
    });
  }

  bool popPage() {
    if(Navigator.of(this.currentContext()).canPop()) {
      Navigator.of(this.currentContext()).pop();
      return true;
    }
    return false;
  }

  bool popPageToRoot() {
    if(Navigator.of(this.currentContext()).canPop()) {
      Navigator.of(this.currentContext()).popUntil((Route<dynamic> route) => route.isFirst);
      return true;
    }
    return false;
  }

  replacePage(page) {
    BuildContext context = this.currentContext();
    bool popped = popPage();
    if(!popped) {

      stateList.clear();
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => page),
      );
    } else {
      pushPage(page);
    }
  }


  int currentPageIndex() {
    return stateList.length-1;
  }



}
