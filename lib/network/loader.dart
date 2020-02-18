import 'package:flutter/material.dart';

class Loader {
  BuildContext _context;
  BuildContext context;
  bool _loadingIsExist = false;


  Loader(BuildContext _context) {
    this._context = _context;
  }

  bool isLoading() {
    return _loadingIsExist;
  }

  void showLoader() {
    _loadingIsExist = true;
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        context = dialogContext;
        return new Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[
            CircularProgressIndicator(),
          ],
        );
      },
    );
  }

  void dismisLoader() {
    _loadingIsExist = false;
    Navigator.of(context, rootNavigator: true).pop();
  }
}
