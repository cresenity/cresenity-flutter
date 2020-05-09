


class C {


  static bool isScalar(Object value) {
    if(value==null) {
      return true;
    }
    return value is String || value is int || value is bool || value;
  }
}