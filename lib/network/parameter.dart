import 'dart:collection';
import 'dart:convert';

/**
 * Created by ipul on 10/16/19.
 */

class Parameter {

  Map<String, Object> data;

  Parameter() {
    this.data = new HashMap();
  }

  Parameter set(String key, Object value) {
    data[key] = value;
    return this;
  }

  Map<String, Object> getData() {
    return data;
  }

  setData(Map<String, Object> data){
    this.data = data;
  }

  String getJson() {
    String result = json.encode(data);
    return result;
  }

}