


import 'package:flutter/material.dart';

import 'router/route.dart';

class CFRouter {
  CFRouter._();
  static final CFRouter _instance = new CFRouter._();

  Map<String,dynamic> routes = {};

  factory CFRouter() {
    return _instance;
  }



  addRoute(uri,action) {
    return this.routes[uri] = _createRoute(uri, action);
  }


  CFRoute _createRoute (uri, action) {

    // If the route is routing direct to Route<T> object we override with callable

    if (action is Route) {
      action = _createDefaultAction(action);
    }
    CFRoute route = _newRoute(uri,action);
    return route;



  }

  CFRoute _newRoute(uri, action) {
    return CFRoute(uri, action);
  }

  _createDefaultAction(route) {
    return () {
      return route;
    };
  }
}