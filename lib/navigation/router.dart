import 'package:flutter/material.dart';
import 'package:pictile/navigation/my_page_route.dart';
import 'package:pictile/navigation/routes.dart';
import 'package:pictile/ui/home/home_page.dart';
import 'package:pictile/ui/manage/add/add_set_page.dart';
import 'package:pictile/ui/manage/menu/manage_menu_page.dart';
import 'package:pictile/ui/show/show_page.dart';
import 'package:pictile/utils/logger.dart';

import 'stack.dart' as s;

class Router with NavigatorObserver {
  static const String _TAG = 'RouteGenerator';

  s.Stack<String> _routes = s.Stack();

  get lastRoute => _routes.top();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    _routes.push(settings.name);
    Log.d(_TAG, 'generateRoute (${settings.name})');

    switch (settings.name) {
      case homeRoute:
        return MyPageRoute(builder: (_) => HomePage());

      case manageMenuRoute:
        return MyPageRoute(builder: (_) => ManageMenuPage());

      case showMenuRoute:
        return MyPageRoute(builder: (_) => ShowPage());

      case manageAddRoute:
        return MyPageRoute(builder: (_) => AddSetPage());

      default:
        return _errorRoute('No path specified for: ${settings.name}.');
    }
  }

  Route<dynamic> _errorRoute(String msg) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Text('ERROR ROUTE \n$msg'),
        ),
      );
    });
  }

  @override
  void didPop(Route route, Route previousRoute) {
    if (route is MaterialPageRoute || route is MyPageRoute) {
      _routes.pop();
      Log.d(_TAG, 'popped page');
    } else {
      Log.d(_TAG, 'popped not page');
    }

    super.didPop(route, previousRoute);
  }

  // Navigator.pushNamedAndRemoveUntil should be used only with
  // homeRoute being pushed.
  @override
  void didRemove(Route route, Route previousRoute) {
    var top = lastRoute;
    if (top == homeRoute) {
      _routes = s.Stack();
      _routes.push(homeRoute);
    } else {
      _routes = s.Stack();
      _routes.push(homeRoute);
      _routes.push(top);
    }

    super.didRemove(route, previousRoute);
  }
}
