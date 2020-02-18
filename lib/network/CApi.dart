
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'paginator.dart';
import 'parameter.dart';

import 'api.dart';

/**
 * @author Muhammad Harisuddin Thohir <me@harisuddin.com>
 * @since 2020-02-12 10:40
 * @license Ittron Global Teknologi <ittron.co.id>
 */


class CApi {
  BuildContext context;
  CApi(this.context);

  static CApi of(BuildContext context){
    return CApi(context);
  }

  request(String method, {dynamic parameter, ScrollController scrollController,
    Function(dynamic data) onSuccess, Function(dynamic error) onError,
    Function(dynamic exp) onException, Function onComplete,
    Function(bool isLoading) onLoading, bool showLoading = false}) async{

    if(onLoading != null){
      onLoading(true);
    }

    Api.createDefaultParams((params) {
      Api api = Api(context);
      api.setLoading(showLoading);

      if (parameter is Parameter) {
        parameter.data.forEach((key, value) {
          params.set(key, value);
        });
      } else if (parameter is Map<String, Object>) {
        parameter.forEach((key, value) {
          params.set(key, value);
        });
      }

      if (scrollController != null) {
        api.createPaginator().setScrollController(scrollController);
      }

      api.setErrorListener((err) {
        if (onLoading != null) {
          onLoading(false);
        }

        if (onError == null) {
          Flushbar(
            title: "Error ${err.errCode}",
            message: err.errMessage,
            duration: Duration(seconds: 3),
          )
            ..show(context);
        } else {
          onError(err);
        }
      });

      api.setExceptionListener((exp) {
        if (onLoading != null) {
          onLoading(false);
        }

        if (onException == null) {
          Flushbar(
            title: "Exception Error",
            message: exp.toString(),
            duration: Duration(seconds: 3),
          )
            ..show(context);
        } else {
          onException(exp);
        }
      });

      api.setCompleteListener(() {
        if (onLoading != null) {
          onLoading(false);
        }
        if (onComplete != null) {
          onComplete();
        }
      });

      try {
        api.execute(method, params, (response) {
          if (scrollController != null) {
            Paginator paginator = response.api.getPaginator();
            if (paginator != null) {
              paginator.setCurrentPage(response.data()['currentPage']);
              String perPage = "${response.data()['perPage']}";
              paginator.setPerPage(int.parse(perPage));
              paginator.setTotal(response.data()['total']);
              paginator.setLastPage(response.data()['lastPage']);
            }
          }

          Map data = response.data();
          onSuccess(data);
        });
      } catch (exp) {
        if (onLoading != null) {
          onLoading(false);
        }
        Flushbar(
          title: "Exception Error",
          message: exp.toString(),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });
  }

}
