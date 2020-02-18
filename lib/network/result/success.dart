import '../api.dart';
import '../result.dart';


/**
 * @author Muhammad Harisuddin Thohir <me@harisuddin.com>
 * @since 2019-10-18 21:04
 * @license Ittron Global Teknologi <ittron.co.id>
 */

class Success extends Result{
  Map _data;

  Success(Api api, Map data) : super(api){
    this._data = data;
  }

  Map data() {
    return this._data;
  }
}