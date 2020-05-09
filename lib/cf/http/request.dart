

import 'param_collection.dart';

class Request {
    String url;
    String method;
    Object data;
    String dataType;
    ParamCollection _paramCollection;
    Request({String url, String method = 'GET', Object data, String dataType = 'text'}) {
        this.url = url;
        this.method = method;
        this.data = data;
        _paramCollection = ParamCollection(items:data);
        this.dataType = dataType;

    }

    get paramCollection => _paramCollection;





}