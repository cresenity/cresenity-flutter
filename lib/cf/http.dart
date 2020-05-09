


import 'http/adapter.dart';
import 'http/factory.dart';
import 'http/request.dart';
import 'http/response.dart';

class CFHttp {
  static const String ADAPTER_HTTP = 'http';

  CFHttp._();
  static final CFHttp _instance = new CFHttp._();

  String _adapterType = ADAPTER_HTTP;
  factory CFHttp() {
    return _instance;
  }

  get adapterType => _adapterType;

  void setAdapterType(String type) {
    this._adapterType = type;
  }

  Adapter _adapter() {
    return Factory.createAdapter(adapterType);

  }


  Future<Response> waitRequest({
    String url,
    String method = 'GET',
    String data = '',
    String dataType = 'text',
  }) {
    Request request = Request(url:url, method:method,data:data,dataType: dataType);

    return this._adapter().request(request);
  }

  void request({
    String url,
    String method = 'GET',
    String data = '',
    String dataType = 'text',
    Function onSuccess,
    Function onError,
    Function onCompleted,
  }) async {

    Request request = Request(url:url, method:method,data:data,dataType: dataType);

    Response response = await this._adapter().request(request);

    if(response.statusCode==200) {
      if(onSuccess!=null) {
        onSuccess(response);
      }
    } else {
      if(onError!=null) {
        onError(response);
      }
    }

    if(onCompleted!=null) {
      onCompleted(response);
    }


  }


}