import 'package:cresenity/router.dart';
import 'package:cresenity/utils.dart';
import 'package:example/constant/assets.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

/**
 * @author Muhammad Harisuddin Thohir <me@harisuddin.com>
 * @since 2020-02-17 21:16
 * @license Ittron Global Teknologi <ittron.co.id>
 */


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_){
      Router.navigate(context, MainPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    Utils.requestDark();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            Image.asset(Assets.app_logo, width: 84,),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(
                      fontSize: 48,
                      color: Colors.red[800],
                  ),
                  children: [
                    TextSpan(text: 'C', style: TextStyle(
                      fontWeight: FontWeight.bold
                    )),
                    TextSpan(text: 'F', style: TextStyle(
//                    color: Colors.blue[800]
                    )),
                    TextSpan(
                        style: TextStyle(
                            fontSize: 14
                        ),
                        children: [
                          TextSpan(text: '\nCresenity ', style: TextStyle(
                            fontStyle: FontStyle.italic
//                            fontWeight: FontWeight.bold
//                            color: Colors.blue[800]
                          )),
                          TextSpan(text: 'Framework', style: TextStyle(
                              color: Colors.blue[800],
                              fontStyle: FontStyle.italic
                          ))
                        ]
                    ),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
