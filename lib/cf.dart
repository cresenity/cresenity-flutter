library cresenity;

import 'cf/app.dart';
import 'cf/bloc/bloc_manager.dart';
import 'cf/config.dart';
import 'cf/http.dart';
import 'cf/storage.dart';
import 'cf/trace.dart';
import 'cf/ui.dart';
import 'logger.dart';



class CF {

  static Future<void> setup() async {

    await getStorage().setup();
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


  static log(message) {
    logger().d(message);
  }
  static CFStorage getStorage({String adapter}) {
    return CFStorage(adapter: adapter);
  }

  static CFApp get app => CFApp();
  static CFStorage get storage => CFStorage();
  static CFHttp get http => CFHttp();
  static CFTrace get trace => CFTrace();
  static CFConfig get config => CFConfig();
  static CFUI get ui => CFUI();
  static CFBlocManager get bloc => CFBlocManager();


}