



import 'dialog/builder.dart';

class CFUIDialog {

  static final CFUIDialog _instance = new CFUIDialog._();

  factory CFUIDialog() {
    return _instance;
  }


  CFUIDialog._();






  alert(String message) {
    CFUIDialogBuilder(
      message:message,
    ).addAction('Close').show();
  }

  confirm(String message, Function(bool confirmed) onConfirmed) {
    CFUIDialogBuilder(
      message:message,
    ).addAction('Yes',onClick: (context) {
      onConfirmed(true);
    }).addAction('No',onClick: (context) {
      onConfirmed(false);
    }).show();


  }

}