import 'package:flutter/material.dart';
import 'package:cresenity/ui/ui.dart';

class BasicFloatingActionButton extends StatelessWidget {
  IconData icon;
  Widget builder;
  VoidCallback onPressed;
  bool isMini;
  List<Color> colors;


  BasicFloatingActionButton({
    IconData icon,
    Widget builder,
    VoidCallback onPressed,
    bool isMini=false,
    List<Color> colors
  }) {
    if(colors==null) {
      colors = UI.defaultGradients;
    }
    this.icon = icon;
    this.builder = builder;
    this.onPressed = onPressed;
    this.isMini = isMini;
    this.colors = colors;

  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      clipBehavior: Clip.antiAlias,
      mini: isMini,
      onPressed: onPressed,
      child: Ink(
        decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: colors)),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            builder != null
                ? Positioned(
              right: 7.0,
              top: 7.0,
              child: CircleAvatar(
                backgroundColor: Colors.red,
                child: builder,
                radius: 10.0,
              ),
            )
                : Container(),
            // builder
          ],
        ),
      ),
    );
  }
}