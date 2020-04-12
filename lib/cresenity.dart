library cresenity;

import 'package:cresenity/constant/config.dart';

//import 'constant/config.dart' as conf;

class Cresenity {
  int addOne(int value) => value + 1;
  static config({
    String appName = 'app_name',
    String protocol = 'http',
    String developmentDomain = 'development.cresenity.com',
    String productionDomain = 'cresenity.com',
    String pathUrl = '/api/member/',
    String developmentAuthId = 'development_auth_id',
    String productionAuthId = 'production_auth_id',
    bool isProduction = false,
    bool useSecureConnection = false,
    bool enableForceLogger = false,
  }){
    AppConfig.appName = appName;
    AppConfig.isProduction = isProduction;
    AppConfig.developmentDomain = developmentDomain;
    AppConfig.productionDomain = productionDomain;
    AppConfig.pathUrl = pathUrl;

    if(useSecureConnection){
      protocol = 'https';
    }else{
      protocol = 'http';
    }

    if(isProduction){
      AppConfig.authId = productionAuthId;
      AppConfig.baseUrl = "$protocol://$productionDomain$pathUrl";
    }else{
      AppConfig.authId = developmentAuthId;
      AppConfig.baseUrl = "$protocol://$developmentDomain$pathUrl";
    }

    AppConfig.isProduction = isProduction;
    AppConfig.useSecureConnection = useSecureConnection;
    AppConfig.enableForceLogger = enableForceLogger;

  }
}
