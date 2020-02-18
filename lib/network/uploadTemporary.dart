import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'api.dart';
import 'result/upload.dart';

/**
 * Created by ipul on 10/23/19.
 */

class UploadTemporary {
  BuildContext _context;
  OnSuccessUpload _onSuccessUpload;
  OnErrorUpload _onErrorUpload;
  OnExceptionUpload _onExceptionUpload;
  OnCompleteUpload _onCompleteUpload;

  UploadTemporary(@required this._context);

  UploadTemporary setOnErrorUpload(OnErrorUpload value) {
    _onErrorUpload = value;
    return this;
  }

  UploadTemporary setOnSuccessUpload(OnSuccessUpload value) {
    _onSuccessUpload = value;
    return this;
  }

  UploadTemporary setOnExceptionUpload(OnExceptionUpload value) {
    _onExceptionUpload = value;
  }

  UploadTemporary setOnCompleteUpload(OnCompleteUpload value) {
    _onCompleteUpload = value;
  }

  List<Upload> _ToListandMap(String responseBody) {
    Map data = json.decode(responseBody);
    var videos = data['files']; //returns a List of Maps
    final casting = videos.cast<Map<String, dynamic>>();
    return casting.map<Upload>((json) => Upload.fromJson(json)).toList();
  }

  void execute(String path, OnSuccessUpload onSuccessUpload) {
    int errCode = 0;
    String errMessage = "";

    if (onSuccessUpload != null) {
      this._onSuccessUpload = onSuccessUpload;
    }

    if (this._onErrorUpload == null) {
      this._onErrorUpload = (message) {
        Toast.show(message, _context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      };
    }

    if (this._onExceptionUpload == null) {
      this._onExceptionUpload = (ex) {
        Toast.show(ex.toString().replaceAll("Exception: ", ""), _context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      };
    }

    File file = new File(path);
    if (!file.existsSync()) {
      errCode++;
      errMessage = "File is null";
    }

    if (errCode == 0) {
      Api.createDefaultParams((params){
        params.set("files", file);
        Api api = new Api(_context);
        api.setLoading(false);
        api.setErrorListener((response) {
          this._onErrorUpload(response.errMessage);
        });
        api.setExceptionListener((ex) {
          this._onExceptionUpload(ex);
        });
        api.execute("UploadTemporary", params, (response) {
          String data = json.encode(response.data());
          List<Upload> listData = _ToListandMap(data);
          this._onSuccessUpload(listData);
        });

        if (this._onCompleteUpload != null) {
          this._onCompleteUpload();
        }
      });
    }

    if (errCode > 0) {
      try {
        throw new Exception(errMessage);
      } catch (ex) {
        this._onExceptionUpload(ex);
      }
    }
  }
}

typedef OnSuccessUpload = void Function(List<Upload> data);
typedef OnErrorUpload = void Function(String message);
typedef OnExceptionUpload = void Function(Exception ex);
typedef OnCompleteUpload = void Function();
