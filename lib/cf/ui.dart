




import 'ui/blocker.dart';
import 'ui/builder.dart';
import 'ui/dialog.dart';
import 'ui/icon/material_icon.dart';

class CFUI {


  static final CFUI _instance = new CFUI._();

  factory CFUI() {
    return _instance;
  }

  CFUI._() {

  }

   CFUIBlocker get blocker => CFUIBlocker();

   CFUIBuilder get builder => CFUIBuilder();

   CFUIDialog get dialog => CFUIDialog();

}
