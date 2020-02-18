import '../result.dart';
import '../api.dart';

/**
 * Created by ipul on 10/21/19.
 */

class Error extends Result {
  dynamic _errCode;
  dynamic _errMessage;
  Error(Api api, dynamic errCode, dynamic errMessage) : super(api) {
    this._errCode = errCode;
    this._errMessage = errMessage;
  }

  String get errMessage => _errMessage.replaceAll("Exception: ", "");

  dynamic get errCode => _errCode;


}