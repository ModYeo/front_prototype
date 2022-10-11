
import 'root_route_navigator.dart';

import 'login_route_navigator.dart';

class RouteNav{
  static final RouteNav instance = RouteNav._constructor();

  RouteNav._constructor(){}
}

class RouteNavigator {
  static final RouteNavigator _instance = RouteNavigator._constructor();

  factory RouteNavigator(){
    return _instance;
  }

  RouteNavigator._constructor(){

  }

  final _rootRoute = RootTrackedNavigator();
  RootTrackedNavigator get root => _rootRoute;

  final _loginRoute = LoginTrackedNavigator();
  LoginTrackedNavigator get login => _loginRoute;
}

