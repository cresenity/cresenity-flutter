


import 'package:flutter/material.dart';

import 'blocker/progress_dialog.dart';

class Blocker {
  static final Blocker _instance = new Blocker._();

  factory Blocker() {
    return _instance;
  }

  BuildContext _lastContext;

  ProgressDialog _progressDialog;
  Blocker._();

  void blockPage(BuildContext context) async {
    if(_lastContext!=null) {
      return;
    }

    _lastContext = context;
    _progressDialog = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false);
    _progressDialog.style(message: 'Loading...');
    await _progressDialog.show();
  }

  void unblockPage() async {

    if(_lastContext!=null) {
      if(_progressDialog!=null) {
        await _progressDialog.hide();
        _progressDialog = null;
      }
      _lastContext = null;
    }
  }
}