library cresenity;

import 'logger.dart';
import 'ui/app.dart';


class CF {
  static Logger logger() {
    return Logger(
      printer: PrettyPrinter(methodCount: 0),
    );
  }

  static Logger loggerWithTrace() {
    return Logger(
      printer: PrettyPrinter(),
    );
  }

  static App app() {
    return App();
  }

}