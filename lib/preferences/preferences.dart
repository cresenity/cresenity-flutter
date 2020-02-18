import 'dart:convert';

import 'package:cresenity/log.dart';
import 'package:shared_preferences/shared_preferences.dart';


/**
 * Created by ipul on 10/21/19.
 */

class Preferences {
  static String SESSION = "session";
  static String VERSION = "version";
  static String CLOUD_MESSAGING = "cloud_messaging";
  static String MEMBER = "member";
  static String PASSWORD = "password";
  static String EMAIL = "email";
  static String LOGIN_WITH = "login_with";
  static String HASH_PASSWORD = "hash_password";

  static void setSession(String session) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SESSION, session);
  }

  static Future<String> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SESSION);
  }

  static void setVersion(String version) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(VERSION, version);
  }

  static Future<String> getVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(VERSION);
  }

  static void setMember(String member) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(MEMBER, member);
  }


  static void setCloudMessaging(String cloud_messaging_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CLOUD_MESSAGING, cloud_messaging_id);
  }

  static Future<String> getCloudMessaging() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(CLOUD_MESSAGING);
  }

  static void setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(EMAIL, email);
  }

  static Future<String> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(EMAIL);
  }

  static void setPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PASSWORD, password);
  }

  static Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(PASSWORD);
  }

  static void setLoginWith(String loginWith) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(LOGIN_WITH, loginWith);
  }

  static Future<String> getLoginWith() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(LOGIN_WITH);
  }

  static void setHashPassword(bool hashPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(HASH_PASSWORD, hashPassword);
  }

  static Future<bool> getHashPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(HASH_PASSWORD);
  }

  static Future<bool> saveDate(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      if (value is bool) {
        await prefs.setBool(key, value);
      } else if (value is String) {
        await prefs.setString(key, value);
      } else if (value is List<String>) {
        await prefs.setStringList(key, value);
      } else if (value is int) {
        await prefs.setInt(key, value);
      } else if (value is double) {
        await prefs.setDouble(key, value);
      }else{
        Log('Cannot save data!\nData type not supported.');
        return false;
      }
      return true;
    }catch(exp){
      Log(exp.toString());
      return false;
    }
  }

  static Future<dynamic> getData(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

}
