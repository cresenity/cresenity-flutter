import 'api.dart';

/**
 * @author Muhammad Harisuddin Thohir <me@harisuddin.com>
 * @since 2019-10-18 20:57
 * @license Ittron Global Teknologi <ittron.co.id>
 */


class Result {

  Api _api;

  Result(Api api){
   this._api = api;
  }

  Api get api => _api;

}