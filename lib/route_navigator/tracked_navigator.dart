
import 'package:flutter/material.dart';

import '../data_structure.dart';

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

abstract class RouteGenerator{
  MaterialPageRoute PathRoute(RouteSettings settings);
  Future<bool> ReturnRoute();
}

abstract class CustomRoute{
  List<String> get values;
}
