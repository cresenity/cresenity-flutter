

import 'dart:io';

import 'package:async/async.dart';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../cf.dart';
import '../adapter.dart';
import '../request.dart';
import '../response.dart';
import 'package:path/path.dart' as path;


class HttpAdapter extends Adapter {


  Future<Response> request(Request request) async {

    var httpRequest = http.MultipartRequest(request.method.toUpperCase(), Uri.parse(request.url));

    request.paramCollection.asPostStringMap().forEach((key,value) {
      httpRequest.fields[key]=value;
    });

    request.fileCollection.forEach((key,value) {
      if (!value is File) {
        return null;
      }
      File file = value as File;
      if (file.existsSync()) {
        String filePath = file.path;

        String basename = path.basename(filePath);
        var stream = new http.ByteStream(
            DelegatingStream.typed(file.openRead()));
        var length = file.lengthSync();
        http.MultipartFile multipartFile =
        new http.MultipartFile("$key", stream, length, filename: basename);
        httpRequest.files.add(multipartFile);
      }

    });

    var httpResponse = await httpRequest.send();
    String responseBody = await httpResponse.stream.bytesToString();

    Response response = Response(body: responseBody, statusCode:httpResponse.statusCode);

    return response;

  }
}