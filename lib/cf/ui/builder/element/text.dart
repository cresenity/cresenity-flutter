




import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../cf.dart';
import '../../../../helper/str.dart';
import 'base.dart';

class CFUIElementText extends CFUIElementBase {

  final String name="Text";

  String text;
  CFUIElementText([this.text='']);

  Widget _textWidget() {
    CF.log(text);
    CF.log(styles.getTextAlign());
    return Text(
      text,
      style: TextStyle(
        color: styles.getColor(),
        fontWeight: styles.getFontWeight(),
        fontSize: styles.getFontSize(),

      ),
      textAlign: styles.getTextAlign(),
    );
  }

  @override
  Widget toWidget() {
    //return _textWidget();
    return getWrapper(
      child: _textWidget()
    );



  }

  @override
  String printTree({int level=0}) {
    String indent = Str.repeat("  ", level);


    StringBuffer sb = StringBuffer();
    sb.write('${indent}<${name.toLowerCase()} style="${styles.toString()}">');


    sb.write(text);
    sb.writeln('</${name.toLowerCase()}>');


    return sb.toString();
  }

  @override
  String computedString({int level=0}) {
    String indent = Str.repeat("  ", level);


    StringBuffer sb = StringBuffer();
    sb.write('${indent}<${name.toLowerCase()} style="${styles.computedString()}">');


    sb.write(text);
    sb.writeln('</${name.toLowerCase()}>');


    return sb.toString();
  }

}