



import 'package:flutter/material.dart';
import 'package:cresenity/ui/basic/basic_floating_action_button.dart';
import 'package:cresenity/ui/ui.dart';

class BasicScaffold extends StatelessWidget {
  final appTitle;
  final Widget bodyData;
  final showFAB;
  final showDrawer;
  final backGroundColor;
  final actionFirstIcon;
  final scaffoldKey;
  final floatingIcon;
  final centerDocked;
  final elevation;
  final fab;
  final drawer;
  final bottomNav;

  BasicScaffold(
      {this.appTitle ,
        this.bodyData,
        this.showFAB = false,
        this.showDrawer = false,
        this.backGroundColor,
        this.actionFirstIcon = Icons.search,
        this.scaffoldKey,
        this.bottomNav,
        this.centerDocked = false,
        this.floatingIcon,
        this.elevation = 4.0,
        this.fab,
        this.drawer,
      });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey != null ? scaffoldKey : null,
      backgroundColor: backGroundColor != null ? backGroundColor : null,
      appBar: AppBar(
        elevation: elevation,
        backgroundColor: Colors.transparent,
        title: appTitle!=null?Text(appTitle):Text(""),
        actions: <Widget>[
          SizedBox(
            width: 5.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(actionFirstIcon),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      drawer: showDrawer ? drawer : null,
      body: bodyData,
      floatingActionButton: showFAB
          ? fab!=null ? fab: BasicFloatingActionButton(
        builder: centerDocked
            ? Text(
          "5",
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        )
            : null,
        icon: floatingIcon,
        onPressed: () {},
      )
          : null,
      floatingActionButtonLocation: centerDocked
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.endFloat,
      bottomNavigationBar:  bottomNav ,
    );
  }
}