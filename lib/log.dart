

import 'package:cresenity/constant/config.dart';

import 'logger.dart';

/// @author Muhammad Harisuddin Thohir <me@harisuddin.com>
/// @since 2020-01-21 11:19
/// @license Ittron Global Teknologi <ittron.co.id>

class Log{
  static bool enableForceLog = true;
  static bool _enableLog = !AppConfig.isProduction || enableForceLog;
  static bool hasTitle = false;
  static int lineLength = 128;

  static Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: lineLength, // width of the output
      colors: false, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false, // Should each log print contain a timestamp),
    ),
    output: _ConsoleOutput(),
  );

  Log(dynamic message, [String title]){
    v(message, title);
  }

  static d(dynamic message, [String title]){
    if(_enableLog){
      _log(message, Level.debug, title);
    }
  }

  static i(dynamic message, [String title]){
    if(_enableLog){
      _log(message, Level.info, title);
    }
  }

  static v(dynamic message, [String title]){
    if(_enableLog){
      _log(message, Level.verbose, title);
    }
  }

  static w(dynamic message, [String title]){
    if(_enableLog){
      _log(message, Level.warning, title);
    }
  }

  static e(dynamic message, [String title]){
    if(_enableLog){
      _log(message, Level.error, title);
    }
  }

  static wtf(dynamic message, [String title]){
    if(_enableLog){
      _log(message, Level.wtf, title);
    }
  }

  static _log(dynamic message, [Level level, String title]){
    if(title != null){
      print('┌${'─'*(lineLength-1)}');
      for(String val in title.split('\n')){
        print('│ $val');
      }
      hasTitle = true;
    }else{
      hasTitle = false;
    }
    if(level == null){
      _logger.d(message);
    }else{
      _logger.log(level, message);
    }
  }

}

class _ConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      if(Log.hasTitle) line = line.replaceFirst('┌', '├');
      print(line);
    }
  }
}