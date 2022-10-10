import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnamed_project/http_model/httpModel.dart';
import 'package:unnamed_project/route_navigator/route_navigator.dart';
import 'package:unnamed_project/theme/style.dart';
import 'models/user.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserData())
    ],
    child: MaterialApp(
      theme: mainTheme,
      initialRoute: LoginRoute.Login.path,
      navigatorKey: RouteNavigator().root.navKey,
      onGenerateRoute: RouteNavigator().RootPathRoute
    ),
  ));
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class UserData with ChangeNotifier{
  late User _user;
  bool loginInState = false;

  User get currentUser => _user;

  UserData(){

  }

  Future<bool> Login(User user) async {
    _user = user;
    return httpModel().testLogin();
  }

  Future<bool> Logout(User user) async {
    _user = user;
    return httpModel().testLogout();
  }
}