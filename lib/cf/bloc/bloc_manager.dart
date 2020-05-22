




import '../bloc.dart';

class CFBlocManager {

  Map<String,dynamic> _blocs;


  static final CFBlocManager _instance = new CFBlocManager._();

  factory CFBlocManager() {
    return _instance;
  }



  CFBlocManager._() {
    _blocs = Map<String,dynamic>();
  }

  CFBloc createBloc<T>({String blocName}) {
    if(blocName!=null) {
      return _blocs[blocName] =  new CFBloc<T>();
    }
    return  new CFBloc<T>();

  }

}
