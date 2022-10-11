import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../login/authenticate.dart';
import '../login/login.dart';
import '../login/signup.dart';
import '../route_navigator/tracked_navigator.dart';

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

class LoginTrackedNavigator extends TrackedNavigator with RouteGenerator{
  @override
  Future<bool> ReturnRoute() async {
    print(currentRoute);
    if(canPop()){
      switch(LoginRoute.parse(currentRoute)){
        case LoginRoute.Authenticate : maybePop(); break;
        case LoginRoute.Signup : maybePop(); break;
        default : break;
      }
    }
    return false;
  }

  @override
  MaterialPageRoute PathRoute(RouteSettings settings) {
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
}
