



import 'package:flutter/material.dart';

import '../element.dart';
import '../listener.dart';

abstract class CFUIElementBase extends CFUIElement {



  Widget _getGestureWrapper({@required Widget child}) {
    return GestureDetector(
      child:child,
      onTap:() {
        listeners.run(ListenerType.click);
      }
    );
  }

  Widget getWrapper({@required Widget child}) {
    if(listeners.have(ListenerType.click)) {
      return _getGestureWrapper(child: _getContainerWrapper(child: child));
    }
    return _getContainerWrapper(child: child);
  }

  Widget _getContainerWrapper({@required Widget child}) {
    return Container(
        width: styles.getWidth(),
        height: styles.getHeight(),
        margin: styles.getMargin(),
        padding: styles.getPadding(),
        decoration: BoxDecoration(
          border: styles.getBorder(),
          //border: Border.all(width: 1),
          color: styles.getBackgroundColor(),
          borderRadius: styles.getBorderRadius(),



        ),
        constraints: BoxConstraints(
          minWidth: styles.getMinWidth(),
          maxWidth: styles.getMaxWidth(),
        ),

        child: child


    );
  }
}