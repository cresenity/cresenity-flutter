

abstract class Adapter {

  String get(String key,{String defaultValue});
  Future<bool> put(String key,String value);
  Future<bool> unset(String key);

  Future<void> setup();
}