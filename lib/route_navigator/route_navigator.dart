import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Home/home.dart';
import '../login/authenticate.dart';
import '../login/login.dart';
import '../login/signup.dart';
import '../main.dart';
import '../testPage/testPage.dart';
import '../data_structure.dart';

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

enum LoginRoute {
  Error         (path : '/error'),
  Login         (path : '/login'),
  Authenticate  (path : '/authenticate'),
  Signup        (path : '/signup');

  const LoginRoute({required this.path});
  final String path;

  static LoginRoute parse(String? name){
    for(LoginRoute route in LoginRoute.values){
      if(name == route.path) return route;
    }
    return LoginRoute.Error;
  }
}

class RouteNavigator {
  static final RouteNavigator _instance = RouteNavigator._constructor();

  factory RouteNavigator(){
    return _instance;
  }

  RouteNavigator._constructor(){

  }
//region root
  final _rootRoute = TrackedNavigator();
  TrackedNavigator get root => _rootRoute;

  MaterialPageRoute RootPathRoute(RouteSettings settings){
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
//endregion

//region login
  final _loginRoute = TrackedNavigator();
  TrackedNavigator get login => _loginRoute;

  MaterialPageRoute LoginPathRoute(RouteSettings settings){
    WidgetBuilder builder;
    final route = LoginRoute.parse(settings.name);
    switch(route){
      case LoginRoute.Login: builder = (context) => ChangeNotifierProvider(create: (context) => LoginPageViewModel(context), child: LoginPageView(),); break;
      case LoginRoute.Authenticate : builder = (context) => ChangeNotifierProvider(create: (context) => AuthenticatePageViewModel(context), child: AuthenticatePageView()); break;
      case LoginRoute.Signup: builder = (context) => ChangeNotifierProvider(create: (context) => SignupPageViewModel(context), child: SignupPageView()); break;
      default :builder = (context) => Text('error'); break;
    }
    return MaterialPageRoute(builder: builder);
  }

  Future<bool> LoginPathReturnRoute() async {
    print(login.currentRoute);
    if(login.canPop()){
      switch(LoginRoute.parse(login.currentRoute)){
        case LoginRoute.Authenticate : login.maybePop(); break;
        case LoginRoute.Signup : login.maybePop(); break;
        default : break;
      }
    }
    return false;
  }
//endregion
}

class TrackedNavigator{
  final _navKey = GlobalKey<NavigatorState>();
  final StackData<String> _routeStack = StackData<String>();

  GlobalKey<NavigatorState> get navKey => _navKey;

  String get currentRoute => _routeStack.peek();

  TrackedNavigator(){}

  void pop(){
    _navKey.currentState!.pop();
  }

  bool canPop() {
    return _navKey.currentState!.canPop();
  }

  Future<void> maybePop() async {
    print('pop');
    if(await _navKey.currentState!.maybePop() && !_routeStack.isEmpty) {
      _routeStack.pop();
    }
  }

  void pushNamed(String path){
    _navKey.currentState!.pushNamed(path);
    _routeStack.push(path);
  }

  void pushReplacementNamed(String path){
    _navKey.currentState!.pushReplacementNamed(path);
    _routeStack.push(path);
  }
}
