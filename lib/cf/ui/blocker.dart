


import 'package:flutter/material.dart';

import 'blocker/progress_dialog.dart';

class CFUIBlocker {
  static final CFUIBlocker _instance = new CFUIBlocker._();

  factory CFUIBlocker() {
    return _instance;
  }

  BuildContext _lastContext;

  ProgressDialog _progressDialog;
  CFUIBlocker._();

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