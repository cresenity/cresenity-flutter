import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:async/async.dart';
import 'package:cresenity/constant/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'result/success.dart';
import '../strings.dart';
import '../preferences/preferences.dart';
import '../log.dart';
import 'parameter.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'loader.dart';
import 'result/error.dart';
import 'package:path/path.dart' as path;
import 'paginator.dart';

/**
 * Created by ipul on 10/16/19.
 */

class Api {
  BuildContext _context;
  OnSuccessListener _onSuccessListener;
  OnErrorListener _onErrorListener;
  OnExceptionListener _onExceptionListener;
  OnCompleteListener _onCompleteListener;
  String _appName = AppConfig.appName;
  Loader _loader;
  bool _isLoading;
  bool _isShowDialog;
  Paginator _paginator;

  Api(BuildContext _context) {
    this._context = _context;
    _loader = Loader(_context);
    _isLoading = true;
    _isShowDialog = true;
  }

  Api setSuccessListener(OnSuccessListener _onSuccessListener) {
    this._onSuccessListener = _onSuccessListener;
    return this;
  }

  Api setErrorListener(OnErrorListener _onErrorListener) {
    this._onErrorListener = _onErrorListener;
    return this;
  }

  Api setLoading(bool _isLoading) {
    this._isLoading = _isLoading;
    return this;
  }

  Api setExceptionListener(OnExceptionListener _onExceptionListener) {
    this._onExceptionListener = _onExceptionListener;
    return this;
  }

  Api setCompleteListener(OnCompleteListener _onCompleteListener) {
    this._onCompleteListener = _onCompleteListener;
    return this;
  }

  Api setIsShowDialog(bool value) {
    _isShowDialog = value;
    return this;
  }

  Paginator createPaginator() {
    _paginator = Paginator(this);
    return _paginator;
  }

  Paginator getPaginator() {
    return _paginator;
  }

  static  createDefaultParams(OnCreateDefaultParamsListener callback) async {
    Parameter params = Api.createParams();
    String sessionId = await Preferences.getSession();

    if (sessionId != null && sessionId.isNotEmpty) {
      params.set("sessionId", sessionId);
    }else{
      params.set("sessionId", '');
    }

    callback(params);
  }

  static Parameter createParams() {
    return Parameter();
  }

  BuildContext get context => _context;

  String _getUrl(String _method) {
    String url = "";

    url += AppConfig.baseUrl;
    url += _method;

    return url;
  }

  execute(String _method, Parameter _parameter,
      OnSuccessListener _onSuccessListener) async {
    int _errCode = 0;
    String _errMessage = '';

    if (_onSuccessListener != null) {
      this._onSuccessListener = _onSuccessListener;
    }

    if (_onErrorListener == null) {
      _onErrorListener = (error) {
        if (_method == 'Login' || _method == 'GetInfo' || _method == 'MemberDevices') {
          _showPopupDialog(error.errMessage, null, _method,
              _parameter, _onSuccessListener);
        } else {
          Toast.show(error.errMessage, _context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      };
    }

    if (_onExceptionListener == null) {
      _onExceptionListener = (ex) {
        String msg = ex.toString().replaceAll("Exception: ", "");
        if (ex is SocketException) {
          msg = "\nConnection Not Found \r\n Please check your network connection.";
        }

        if (_method == 'Login' || _method == 'GetInfo' || _method == 'MemberDevices') {
          _showPopupDialog(msg, null, _method,
              _parameter, _onSuccessListener);
        } else {
          Toast.show(msg, _context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        }
      };
    }

    if (_errCode == 0) {
      if (_method == null || _method.isEmpty) {
        _errCode++;
        _errMessage = 'Method empty';
      }
    }

    if (_errCode == 0) {
      if (_parameter == null) {
        _errCode++;
        _errMessage = 'Parameter empty';
      }
    }

    if (_errCode == 0) {
      if (_paginator != null) {
        this
            ._paginator
            .setOnSuccessPaginator(_onSuccessListener)
            .setup(_method, _parameter);
      }
    }

    try {
      if (_errCode == 0) {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          _parameter.set('device', Platform.isAndroid ? 'android' : 'ios');
          executeFuture(_method, _parameter, _onSuccessListener).then((list) {
            String body = list[0];
            Log('Response ($_method)');
            Log(jsonDecode(body));
            http.StreamedResponse response = list[1];
            if (response != null) {
              if (response.statusCode == 200) {
                if (body != null) {
                  Map item = jsonDecode(body);
                  if (_loader.isLoading()) {
                    _loader.dismisLoader();
                  }
                  if (item['errCode'] == 0) {
                    Success success = Success(this, item['data']);
                    _onSuccessListener(success);
                  } else {
                    _onErrorListener(Error(
                        this, item['errCode'], "${item['errMessage']}"));
                  }
                } else {
                  _handleResponseError(response.statusCode.toString(), body,
                      _method, _parameter, _onSuccessListener);
                }
              } else {
                _handleResponseError(response.statusCode.toString(), body,
                    _method, _parameter, _onSuccessListener);
              }
            } else {
              _handleResponseError(
                  null, null, _method, _parameter, _onSuccessListener);
            }

            if (_onCompleteListener != null) {
              _onCompleteListener();
            }
          }).timeout(Duration(seconds: 30), onTimeout: () {
            _handleResponseError(
                null, null, _method, _parameter, _onSuccessListener);
          });
        } else {
          _errCode++;
          _errMessage = Strings.no_internet_akses;
        }
      }
    } on SocketException catch (_) {
      _errCode++;
      _errMessage = Strings.no_internet_akses;
      /*_handleResponseError(
          null, null, _method, _parameter, _onSuccessListener);*/
    } catch (e) {
      _errCode++;
      _errMessage = Strings.no_internet_akses;
    }

    if (_errCode > 0) {
      try {
        throw Exception(_errMessage.replaceAll("Exception: ", ''));
      } catch (ex) {
        _onExceptionListener(ex);
      }
    }
  }

  Future<List> executeFuture(String _method, Parameter _parameter,
      OnSuccessListener _onSuccessListener) async {
    var request = http.MultipartRequest("POST", Uri.parse(_getUrl(_method)));

    _parameter.data.forEach((k, v) async {
      if (v is File) {
        File file = v;
        if (file.existsSync()) {
          String pathh = file.path;
          String basename = path.basename(
              pathh.substring(0, pathh.lastIndexOf(".") + 1) +
                  getMimeType(pathh));
          var stream =
          http.ByteStream(DelegatingStream.typed(file.openRead()));
          var length = file.lengthSync();
          http.MultipartFile multipartFile =
          http.MultipartFile("$k", stream, length, filename: basename);
          request.files.add(multipartFile);
        }
      } else {
        if (v != null) {
          request.fields[k] = "$v";
        }
      }
    });

    if (_isLoading) {
      _loader.showLoader();
    }

    var requestParams = "";
    var index = 0;
    request.fields.forEach((key, val){
      index++;
      requestParams += "$key=$val${ index == request.fields.length ? '' : '&'}";
    });

    Log("Request ($_method) \n${request.url}?$requestParams");
    Log(_parameter.getData());
    var response = await request.send();

    List list = [await response.stream.bytesToString(), response];

    return list;
  }

  void _showAlert(String error) {
    Widget _button() {
      return FlatButton(
        child: Text(
          'Close',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          Navigator.of(_context).pop(); // Dismiss alert dialog
        },
      );
    }

    showDialog(
      context: _context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return Platform.isAndroid
            ? AlertDialog(
          title: Text(
            _appName,
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            error,
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            _button(),
          ],
        )
            : CupertinoAlertDialog(
          title: Text(
            _appName,
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            error ?? '',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            _button(),
          ],
        );
      },
    );
  }

  String getMimeType(String path) {
    String extension = path.substring(path.lastIndexOf(".") + 1);
    return extension.toLowerCase();
  }

  void _handleResponseError(String code, String response, String _method,
      Parameter _parameter, OnSuccessListener _onSuccessListener) {
    if (_loader.isLoading()) {
      _loader.dismisLoader();
    }

    String errCode = "";
    String errMessage = "";

    if (!AppConfig.isProduction) {
      errCode = ". " +
          (Strings.error_code + " ") +
          (code != null && code.isNotEmpty ? code : " 0");
    }

    if (code != null && code.isNotEmpty) {
      if (code == "404") {
        errMessage = Strings.page_not_found + errCode;
      } else {
        errMessage = Strings.an_error_occurred + errCode;
      }
    } else {
      errMessage = Strings.no_internet_akses + errCode;
    }

    if (_isShowDialog) {
      _showPopupDialog(errMessage, response == null ? "" : response, _method,
          _parameter, _onSuccessListener);
    } else {
      if (code == null || code.isEmpty) {
        code = "0";
      }
      _onErrorListener(Error(this, int.parse(code), errMessage));
    }
  }

  List<Widget> _actionButton(
      BuildContext dialogContext,
      String _response,
      String _method,
      Parameter _parameter,
      OnSuccessListener _onSuccessListener) {
    return [
      FlatButton(
        child: Text(
          'Close',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          Navigator.of(dialogContext).pop(); // Dismiss alert dialog
        },
      ),
      FlatButton(
        child: Text(
          'Reload',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () {
          Navigator.of(dialogContext).pop(); // Dismiss alert dialog
          execute(_method, _parameter, _onSuccessListener);
        },
      ),
      !AppConfig.isProduction ?
        FlatButton(
          child: Text(
            'View Error',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(dialogContext).pop();
            _showAlert(_response);
          },
        ) : Container(),
    ];
  }

  _showPopupDialog(String message, String _response, String _method,
      Parameter _parameter, OnSuccessListener _onSuccessListener) {
    showDialog(
      context: _context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return Platform.isAndroid
            ? AlertDialog(
          title: Text(
            _appName,
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
          actions: _actionButton(dialogContext, _response, _method,
              _parameter, _onSuccessListener),
        )
            : CupertinoAlertDialog(
          title: Text(
            _appName,
            style: TextStyle(color: Colors.black),
          ),
          content: Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
          actions: _actionButton(dialogContext, _response, _method,
              _parameter, _onSuccessListener),
        );
      },
    );
  }
}

typedef OnSuccessListener = void Function(Success response);

typedef OnErrorListener = void Function(Error error);

typedef OnExceptionListener = void Function(Exception ex);

typedef OnCompleteListener = void Function();

typedef OnCreateDefaultParamsListener = void Function(Parameter parameter);
