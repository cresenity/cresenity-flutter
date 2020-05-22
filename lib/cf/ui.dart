




import 'ui/blocker.dart';
import 'ui/icon/material_icon.dart';

class CFUI {


  static final CFUI _instance = new CFUI._();

  factory CFUI() {
    return _instance;
  }

  CFUI._() {

  }


  static CFUIBlocker get blocker => CFUIBlocker();

  static CFUIMaterialIcon get materialIcon => CFUIMaterialIcon();
}
