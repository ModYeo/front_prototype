import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnamed_project/http_model/httpModel.dart';
import 'package:unnamed_project/testPage/testPage.dart';
import 'package:unnamed_project/theme/style.dart';
import 'models/user.dart';
import 'Home/home.dart';
import 'login/login.dart';

void main() {
  GlobalKey<NavigatorState> _rootNavigator;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserData())
    ],
    child: MaterialApp(
      theme: mainTheme,
      initialRoute: '/login',
      navigatorKey: _rootNavigator = GlobalKey<NavigatorState>(),
      onGenerateRoute: (RouteSettings settings){
        final arguments = settings.arguments;
        WidgetBuilder builder;
        print(settings.name);

        switch(settings.name){
          case '/login' : builder = (context) => LoginPage(rootNavigator: _rootNavigator,); break;
          case '/home': builder = (context) => Home(); break;
          case '/main_page': builder= (context) => Text('mainPage'); break;
          case '/test' : builder= (context) => TestPage(); break;
          default :builder = (context) => ErrorPage(); break;
        }
        return MaterialPageRoute(builder: builder);
      }
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

class UserData with ChangeNotifier, DiagnosticableTreeMixin{
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