import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cresenity/mage/mage.dart';
import 'package:cresenity/mage/mage_widget.dart';
import 'package:cresenity/mage/mage_action.dart';

import '../../mage/mage_builder.dart';




class MemberListWidget extends StatelessWidget{

  int show=0;

  Mage memberMage = Mage();
  MageAction<int> showAction;



  @override
  Widget build(BuildContext context) {
    showAction = memberMage.createAction<int>("show");


    return MageWidget(
      mage: memberMage,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Member List Widget"),
        ),
        body:Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              showAction.createBuilder((builder) {

                  if(builder.state=="LOADING") {
                    return CircularProgressIndicator();
                  }
                  int value = builder.value;

                  if(value==null) {
                    value=0;
                  }


                  return Text("${builder.state} ${value}");

              }),


            ],
          )


        ),


        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //show = show==1?0:1;


            if(!showAction.isDispatching) {

              showAction.dispatch((result) async* {
                yield "LOADING";
                await new Future.delayed(const Duration(seconds: 2));

                result.setValue(++show);
                yield "LOADED";
              });
            }
          },
          child: Icon(Icons.add),
        ),

      ),

    );


  }


}