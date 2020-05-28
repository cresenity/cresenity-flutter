



import '../storage.dart';
import 'adapter.dart';
import 'adapter/hive_adapter.dart';
import 'adapter/shared_preferences_adapter.dart';

class Factory {

  static Adapter createAdapter(adapterType) {
    Adapter adapter;
    switch(adapterType) {
      case CFStorage.ADAPTER_SHARED_PREFERENCES:
        adapter = SharedPreferencesAdapter();
        break;
      case CFStorage.ADAPTER_HIVE:
        adapter = HiveAdapter();
        break;
    }
    return adapter;
  }

}
