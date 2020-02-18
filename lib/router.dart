/**
 * @ Author: ipul
 * @ Create Time: 2019-10-04 09:16:49
 * @ Modified by: ipul
 * @ Modified time: 2019-10-04 09:35:11
 */

import 'package:flutter/material.dart';

class Router {
  static void push(BuildContext context, Widget page) {
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) => page),
    );
  }

  static void pushNamed(BuildContext context, String page) {
    Navigator.of(context).pushNamed(page);
  }

  static void replace(BuildContext context, Widget page) {
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(builder: (context) => page),
    );
  }

  static void navigate(BuildContext context, Widget page) {
    Navigator.of(context).popUntil((predicate) => predicate.isFirst);
    Navigator.of(context).pushReplacement(
      new MaterialPageRoute(builder: (context) => page),
    );
  }

  static void pop(BuildContext context) {
    if(Navigator.of(context).canPop()){
      Navigator.of(context).pop();
    }
  }

  static void dismissAlert(context) {
    Navigator.of(context).pop();
  }

  static void navigateNamed(BuildContext context, String page) {
    Navigator.of(context).popUntil((predicate) => predicate.isFirst);
    Navigator.of(context).pushReplacementNamed(page);

  }

  static void popOrNavigate(BuildContext context, Widget page){
    if(Navigator.of(context).canPop()){
      Navigator.of(context).pop();
    }else{
      Navigator.of(context).popUntil((predicate) => predicate.isFirst);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => page));
    }

  }
}