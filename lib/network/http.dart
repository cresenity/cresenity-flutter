import 'package:cresenity/constant/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../log.dart';

/// @author Muhammad Harisuddin Thohir <me@harisuddin.com>
/// @since 13/04/20 06.21 
/// @license Ittron Global Teknologi <ittron.co.id>


class Http {
  BuildContext context;
  Http(this.context);

  static Http of(BuildContext context){
    return Http(context);
  }

  static Future<Response> request(String method, {
    dynamic parameter,
    ScrollController scrollController,
    Function(dynamic data) onSuccess,
    Function(dynamic error) onError,
    Function(dynamic exp) onException,
    Function onComplete,
    Function(bool isLoading) onLoading,
    bool showLoading = false
  }) async {
    BaseOptions options = new BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 5000,
    );
    Dio dio = new Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (request){
        Log(request.baseUrl+request.path, "Request");
        Log(request.data, "Request");

        return request;
      },
      onResponse: (response){
        Log(response.request.baseUrl+response.request.path, "Response");
        Log(response.data, "Response");
        int statusCode = response.data['statusCode'] ?? 1;
        if(statusCode == 0){
          if(onSuccess != null){
            onSuccess(response.data['data'] ?? '');
          }
        }else{
          if(onError != null){
            onError(response.data['data'] ?? '');
          }
        }


        return response;
      },
      onError: (err){
        Log(err.message, "Error");

        if(onException != null){
          onException(err.message);
        }
        return err;
      }
    ));

    Response response = await dio.request(
      method,
      data: parameter,
      options: Options(
        method: 'POST'
      )
    );

    return response;
  }


}
