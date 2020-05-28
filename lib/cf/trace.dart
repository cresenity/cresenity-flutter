


import 'package:cresenity/cf.dart';
import 'package:cresenity/cf/trace/trace.dart';

class CFTrace {


  static final CFTrace _instance = new CFTrace._();

  factory CFTrace() {
    return _instance;
  }

  CFTrace._() {

  }

  void logTrace() {
    CF.logger().d(Trace.current());

  }
}