import 'package:flutter/material.dart';

import 'bloc_builder_result.dart';
import 'bloc_state.dart';




class CFBlocBuilder extends StatefulWidget {

  Function builder;
  Stream stream;
  Function init;
  CFBlocBuilder ({
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
  _CFBlocBuilderState createState() => _CFBlocBuilderState();


}



class _CFBlocBuilderState extends State<CFBlocBuilder>{
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

            CFBlocState mageState = null;
            if(snapshot.data!=null) {
              mageState = snapshot.data;

            }


            CFBlocBuilderResult builderResult = CFBlocBuilderResult(context,mageState);
            return widget.builder(builderResult);
          }
      ),
    );

  }
}


