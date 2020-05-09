


class CFConfig {

  Map<String,dynamic> _config;


  static final CFConfig _instance = new CFConfig._();

  factory CFConfig() {
    return _instance;
  }



  CFConfig._() {
    _config = Map<String,dynamic>();
  }

}
