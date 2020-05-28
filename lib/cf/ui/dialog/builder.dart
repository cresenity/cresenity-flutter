


import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../cf.dart';
import 'dialog_action.dart';

class CFUIDialogBuilder {
  BuildContext context;

  String title;
  String message;
  WidgetBuilder builder;

  bool barrierDismissible;
  List<CFUIDialogAction> actions;

  CFUIDialogBuilder({this.context,this.title,this.message,this.builder,this.barrierDismissible}) {
    context = context ?? CF.app.currentContext();

    barrierDismissible = barrierDismissible ?? true;
    actions = List<CFUIDialogAction>();
  }

  List<Widget> _getActions(BuildContext context) {
    List<Widget> widgets = List<Widget>();
    actions.forEach((action){
      widgets.add(action.toWidget(context));
    });
    return widgets;
  }

  _dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }

  CFUIDialogBuilder addAction(String label, {Function(BuildContext context) onClick}) {
    //wrap to dismiss
    Function(BuildContext context) onPressed = (BuildContext context) {
      _dismiss(context);
      if(onClick!=null) {
        onClick(context);
      }
    };
    actions.add(CFUIDialogAction(label:label,onClick: onPressed));
    return this;
  }

  Widget defaultBuilder(BuildContext context) {
    return Platform.isAndroid ? AlertDialog(
      title:  title!=null ? Text(title) : null,
      content: message!=null ? Text(message) : null,
      actions: _getActions(context),
    ): CupertinoAlertDialog(
      title: title!=null ? Text(title) : null,
      content: message!=null ? Text(message) : null,
      actions: _getActions(context),
    );
  }

  WidgetBuilder getBuilder() {
    return builder ?? defaultBuilder;
  }

  show() {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: getBuilder(),
    );
  }


}