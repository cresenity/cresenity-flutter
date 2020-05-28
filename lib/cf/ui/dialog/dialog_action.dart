




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CFUIDialogAction {

  String label = '';
  Function onClick;
  IconData icon;


  CFUIDialogAction({this.label,this.onClick, this.icon}) {

  }


  Widget toWidget(BuildContext context) {
    return FlatButton(
      onPressed: (){
        onClick(context);
      },
      child: Text(label, style: TextStyle(color: Colors.black),
      ),
    );
  }

}