/**
 * Created by ipul on 10/16/19.
 */

class Config {
  static String _urlServerDevelopment = "waroongretjeh.app.ittron.co.id/";
  static String _urlServerProduction = "waroongretjeh.com/"; //live

  static String urlApiServerDevelopment = _urlServerDevelopment + "api/member/";
  static String urlApiServerProduction = _urlServerProduction + "api/member/"; //live

  static String auth_id_development = "6ac0a5f590899cba8adb9afeff5640e9";
  static String auth_id_production = "6ac0a5f590899cba8adb9afeff5640e9"; //live

  static bool productionEnvironment = false;
  static bool secureConnection = false;

  static String getAuthId() {
    String authId;

    if (Config.productionEnvironment) {
      authId = Config.auth_id_production;
    } else {
      authId = Config.auth_id_development;
    }

    return authId;
  }
}