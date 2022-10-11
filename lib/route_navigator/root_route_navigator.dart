import 'package:flutter/material.dart';

import '../Home/home.dart';
import '../login/login.dart';
import '../main.dart';
import '../testPage/testPage.dart';
import '../route_navigator/tracked_navigator.dart';

enum RootRoute {
  Error (path : '/error'),
  Login (path : '/login'),
  Home  (path : '/home'),
  Test  (path : '/test');

  const RootRoute({required this.path});
  final String path;

  static RootRoute parse(String? name){
    for(RootRoute route in RootRoute.values){
      if(name == route.path) return route;
    }
    return RootRoute.Error;
  }
}

class RootTrackedNavigator extends TrackedNavigator with RouteGenerator{
  @override
  MaterialPageRoute PathRoute(RouteSettings settings){
    WidgetBuilder builder;
    final route = RootRoute.parse(settings.name);
    switch(route){
      case RootRoute.Login : builder = (context) => Login(); break;
      case RootRoute.Home: builder = (context) => Home(); break;
      case RootRoute.Test : builder= (context) => TestPage(); break;
      default :builder = (context) => ErrorPage(); break;
    }
    return MaterialPageRoute(builder: builder);
  }

  @override
  Future<bool> ReturnRoute() {
    // TODO: implement ReturnRoute
    throw UnimplementedError();
  }
}
