import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class Utils {

  BuildContext context;

  Utils(BuildContext context) {
    this.context = context;
  }

  Size getScreenSize() {
    return MediaQuery.of(context).size;
  }

  double getScreenWidth() {
    return MediaQuery.of(context).size.width;
  }

  double getScreenHeight() {
    return MediaQuery.of(context).size.height;
  }

  bool isKeyboardHidden() {
    return MediaQuery.of(context).viewInsets.bottom == 0;
  }

  bool isTablet() {
    return getScreenWidth() >= 768;
  }

  static bool isIOS() {
    return Platform.isIOS;
  }

  static bool isAndroid() {
    return Platform.isAndroid;
  }

  static bool isMacOS() {
    return Platform.isMacOS;
  }

  static bool isLinux() {
    return Platform.isLinux;
  }

  static bool isWindows() {
    return Platform.isWindows;
  }

  static bool isFuchsia() {
    return Platform.isFuchsia;
  }

  static String getOS() {
    return Platform.operatingSystem;
  }

  static String getOSVersion() {
    formatCurrency(1000);
    return Platform.operatingSystemVersion;
  }

  static formatCurrency(dynamic amount, {String currency = 'IDR'}) {
    final money = NumberFormat.decimalPattern('id_IDR');
    return 'Rp ${money.format(amount)}';
  }

  static String formatNumber(double number, {String sparator = ','}) {
    final f = new NumberFormat("#,###");
    return f.format(number).replaceAll(',', sparator);
  }

  static loading() {
    return Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  notFound(String message, Future<void> Function() onRefresh, {bool showReload = true}) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Stack(
        children: <Widget>[
          Container(
            height: getScreenHeight(),
            width: getScreenWidth(),
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  RaisedButton(
                    onPressed: onRefresh,
                    child: Text('Reload', style: TextStyle(
                        color: Colors.green[500],
                        fontWeight: FontWeight.w600
                    ),),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                          color: Colors.green[500],
                          width: 1
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(!showReload) SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: getScreenHeight(),
              width: getScreenWidth(),
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  comingSoon() {
    showDialog(
        context: context,
        builder: (_context) {
          return Utils.isIOS()
              ? CupertinoAlertDialog(
            title: Text('Coming Soon'),
            content: Text('This feature will be coming soon.'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(_context);
                  },
                  child: Text('Close')),
            ],
          )
              : AlertDialog(
            title: Text('Coming Soon'),
            content: Text('This feature will be coming soon.'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(_context);
                  },
                  child: Text('Close')),
            ],
          );
        });
  }

  static requestLight({Color statusBarColor}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: statusBarColor ?? Colors.white,
    ));
  }

  static requestDark({Color statusBarColor}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: statusBarColor ?? Colors.white,
    ));
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static bool randomBool() {
    var rnd = new Random();
    return rnd.nextBool();
  }

  static int randomInt({int max}) {
    var rnd = new Random();
    return rnd.nextInt(max ?? 100);
  }

  static double randomDouble({int min, int max}) {
    var rnd = new Random();
    return rnd.nextDouble();
  }

  static String formatDouble(double n, {int numberBehindComa = 2}) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : numberBehindComa);
  }

  static String uuid() {
    var uuid = new Uuid();
    return uuid.v1();
  }
}
