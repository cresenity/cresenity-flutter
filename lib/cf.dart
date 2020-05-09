library cresenity;

import 'cf/app.dart';
import 'cf/config.dart';
import 'cf/http.dart';
import 'cf/storage.dart';
import 'cf/trace.dart';
import 'logger.dart';



class CF {

  static Future<void> setup() async {
    await storage().setup();
  }

  static Logger logger() {
    return Logger(
      printer: PrettyPrinter(methodCount: 0, colors: false),
    );
  }

  static Logger loggerWithTrace() {
    return Logger(
      printer: PrettyPrinter(),
    );
  }

  static CFConfig config() {
    return CFConfig();
  }

  static CFApp app() {
    return CFApp();
  }

  static trace() {
    return CFTrace();
  }

  static CFHttp http() {
    return CFHttp();
  }

  static CFStorage storage({String adapter}) {
    return CFStorage(adapter: adapter);
  }
}