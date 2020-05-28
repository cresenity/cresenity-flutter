library cresenity;

import 'cf/app.dart';
import 'cf/bloc/bloc_manager.dart';
import 'cf/config.dart';
import 'cf/http.dart';
import 'cf/manager.dart';
import 'cf/router.dart';
import 'cf/storage.dart';
import 'cf/trace.dart';
import 'cf/ui.dart';
import 'logger.dart';



class CF {

  static Future<void> setup({Map configMap}) async {

    await CFStorage().setup();
    await CFConfig().setup(configMap:configMap);
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


  static dynamic config(String name,[defaultValue]) {



      return CFConfig().get(name,defaultValue);





  }

  static CFApp get app => CFApp();
  static CFStorage get storage => CFStorage();
  static CFHttp get http => CFHttp();
  static CFTrace get trace => CFTrace();

  static CFUI get ui => CFUI();
  static CFBlocManager get bloc => CFBlocManager();

  static CFRouter get router => CFRouter();

  static CFManager get manager => CFManager();

}