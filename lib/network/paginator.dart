import 'package:flutter/material.dart';
import 'api.dart';
import 'result/success.dart';
import 'parameter.dart';

/**
 * Created by ipul on 10/24/19.
 */

class Paginator {
  int _currentPage;
  int _perPage;
  int _lastPage;
  int _total;
  Api _api;
  ScrollController _scrollController;
  OnSuccessPaginator _onSuccessPaginator;
  bool _isLoading = true;
  double _initialHeight = 0;

  Paginator(Api api) {
    this._currentPage = 1;
    this._perPage = 10;
    this._lastPage = 0;
    this._api = api;
    this._total = 0;
  }

  Paginator setTotal(int value) {
    this._total = value;
    return this;
  }

  Paginator setLastPage(int value) {
    this._lastPage = value;
    return this;
  }

  Paginator setPerPage(int value) {
    this._perPage = value;
    return this;
  }

  Paginator setCurrentPage(int value) {
    this._currentPage = value;
    return this;
  }

  Paginator setScrollController(ScrollController scrollController) {
    this._scrollController = scrollController;
    return this;
  }

  Paginator setOnSuccessPaginator(OnSuccessPaginator value) {
    this._onSuccessPaginator = value;
    return this;
  }

  void setup(String _method, Parameter _parameter) {
    this._scrollController.addListener(() {
      if(_initialHeight == 0){
        _initialHeight = _scrollController.position.maxScrollExtent;
      }
      double requestPosition = this._scrollController.position.maxScrollExtent - (_initialHeight*0.75);

      if (this._scrollController.position.pixels > requestPosition &&
          this._currentPage < this._lastPage && _isLoading) {
        debugPrint("position : ${_scrollController.position.pixels} "
            "\n request : $requestPosition "
            "\n max : ${_scrollController.position.maxScrollExtent}");
        _isLoading = false;
        int currentPages = this._currentPage + 1;
        _parameter.set("page", "$currentPages");
        _parameter.set("perPage", this._perPage.toString());
        new Api(this._api.context).setLoading(false).execute(
            _method, _parameter, (response) {
          Success success = new Success(this._api, response.data());
          this._isLoading = true;
          this._onSuccessPaginator(success);
        });
      }
    });
  }
}

typedef OnSuccessPaginator = void Function(Success response);
