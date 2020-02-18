library cresenity;

import 'constant/config.dart' as conf;

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
    conf.appName = appName;
    conf.isProduction = isProduction;
    conf.developmentDomain = developmentDomain;
    conf.productionDomain = productionDomain;
    conf.pathUrl = pathUrl;

    if(useSecureConnection){
      protocol = 'https';
    }else{
      protocol = 'http';
    }

    if(isProduction){
      conf.authId = productionAuthId;
      conf.fullUrl = "$protocol://$productionDomain$pathUrl";
    }else{
      conf.authId = developmentAuthId;
      conf.fullUrl = "$protocol://$developmentDomain$pathUrl";
    }

    conf.isProduction = isProduction;
    conf.useSecureConnection = useSecureConnection;
    conf.enableForceLogger = enableForceLogger;

  }
}
