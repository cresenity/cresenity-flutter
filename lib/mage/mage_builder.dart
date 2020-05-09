import 'package:flutter/material.dart';

import 'mage_action.dart';
import 'mage_builder_result.dart';
import 'mage_state.dart';


class MageBuilder extends StatefulWidget {

  Function builder;
  Stream stream;
  Function init;
  MageBuilder ({
    Key key,
    Function builder,
    Stream stream,
    Function init,
  }): super(key: key) {
    this.builder = builder;
    this.init = init;
    this.stream = stream;

  }



  @override
  _MageBuilderState createState() => _MageBuilderState();


}



class _MageBuilderState extends State<MageBuilder>{
  @override
  void dispose(){

    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    return Container(
      child: StreamBuilder(
        stream: widget.stream,
        builder: (context,snapshot) {

          MageState mageState = null;
          if(snapshot.data!=null) {
            mageState = snapshot.data;

          }


          MageBuilderResult builderResult = MageBuilderResult(context,mageState);
          return widget.builder(builderResult);
        }
      ),
    );

  }
}


