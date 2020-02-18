import 'cf.dart';
import 'logger.dart';
import 'constant/config.dart' as config;


/**
 * @author Muhammad Harisuddin Thohir <me@harisuddin.com>
 * @since 2020-02-17 20:43
 * @license Ittron Global Teknologi <ittron.co.id>
 */

class Log{
  Log(dynamic message){
    if(!config.isProduction || config.enableForceLogger){
      CF.logger().log(Level.debug, message);
    }
  }

  static d(dynamic message){
    if(!config.isProduction || config.enableForceLogger) {
      CF.logger().d(message);
    }
  }

  static e(dynamic message){
    if(!config.isProduction || config.enableForceLogger) {
      CF.logger().log(Level.error, message);
    }
  }

  static i(dynamic message){
    if(!config.isProduction || config.enableForceLogger) {
      CF.logger().log(Level.info, message);
    }
  }

  static v(dynamic message){
    if(!config.isProduction || config.enableForceLogger) {
      CF.logger().log(Level.verbose, message);
    }
  }

  static w(dynamic message){
    if(!config.isProduction || config.enableForceLogger) {
      CF.logger().log(Level.warning, message);
    }
  }
}