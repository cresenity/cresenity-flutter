


import 'package:cresenity/cf.dart';
import 'package:cresenity/cf/trace/trace.dart';

class CFTrace {

    CFTrace();

    void logTrace() {
      CF.logger().d(Trace.current());

    }
}