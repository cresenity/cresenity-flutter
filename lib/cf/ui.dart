




import 'ui/blocker.dart';

class CFUI {


  static final CFUI _instance = new CFUI._();

  factory CFUI() {
    return _instance;
  }

  CFUI._() {

  }


  static CFUIBlocker get blocker => CFUIBlocker();
}
