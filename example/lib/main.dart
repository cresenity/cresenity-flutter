import 'package:cresenity/cresenity.dart';
import 'package:cresenity/router.dart';
import 'package:flutter/material.dart';
import 'page/main_page.dart';
import 'page/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    Cresenity.config(
      appName: 'Cresenity FrameWork',
      developmentDomain: 'waroongretjeh.app.ittron.co.id',
      productionDomain: 'waroongretjeh.com',
      pathUrl: '/api/member/',
      developmentAuthId: '6ac0a5f590899cba8adb9afeff5640e9',
      productionAuthId: '6ac0a5f590899cba8adb9afeff5640e9',
      isProduction: false,
      useSecureConnection: false,
    );

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashPage(),
    );
  }
}