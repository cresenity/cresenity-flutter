


import 'package:http/http.dart' as http;

import '../../../cf.dart';
import '../adapter.dart';
import '../request.dart';
import '../response.dart';

class HttpAdapter extends Adapter {


  Future<Response> request(Request request) async {

    var httpRequest = http.MultipartRequest(request.method.toUpperCase(), Uri.parse(request.url));

    request.paramCollection.asPostStringMap().forEach((key,value) {
      httpRequest.fields[key]=value;
    });




    var httpResponse = await httpRequest.send();
    String responseBody = await httpResponse.stream.bytesToString();

    Response response = Response(body: responseBody, statusCode:httpResponse.statusCode);
    return response;

  }
}