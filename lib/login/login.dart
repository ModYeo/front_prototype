import 'package:flutter/material.dart';
import 'package:unnamed_project/login/authenticate.dart';

import '../http_model/httpModel.dart';
import 'signup.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<NavigatorState> rootNavigator;

  const LoginPage({Key? key, required this.rootNavigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {return false;},
      child: Navigator(
          initialRoute: '/login',
          onGenerateRoute: (RouteSettings settings){
            WidgetBuilder builder;

            switch(settings.name){
              case '/login': builder = (context) => LoginPageView(moveToHome: (){ rootNavigator.currentState?.pushReplacementNamed('/home');},); break;//FirstPage(); break;
              case '/authenticate' : builder = (context) => AuthenticatePageView(); break;
              case '/signup': builder = (context) => SignupPageView(); break;
              default :builder = (context) => Text('error'); break;
            }
            return MaterialPageRoute(builder: builder);
          }
      ),
    );
  }
}

class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key, required this.moveToHome}) : super(key: key);

  final VoidCallback moveToHome;

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {

  late TextEditingController _idTextController;
  late TextEditingController _pwTextController;

  bool _enableIDSave = false;
  bool _enableAutoLogin = false;

  @override
  void initState(){
    super.initState();
    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _idTextController.dispose();
    _pwTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Welcome'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email'),
                        TextField(
                          controller: _idTextController,
                          onSubmitted: (text){},
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Password'),
                        TextField(
                          controller: _pwTextController,
                          onSubmitted: (text){},
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(value: _enableIDSave, onChanged: (value){setState((){_enableIDSave = value!;});}),
                          Text('Save ID')
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(value: _enableAutoLogin, onChanged: (value){setState((){_enableAutoLogin = value!;});}),
                          Text('Auto Login')
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () async {
                          var login = await LoginViewModel().ManualLogin();
                          print(login);
                          if(login){
                            widget.moveToHome();
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: (){ Navigator.pushNamed(context, '/authenticate'); },
                        child: const Text('SignUp')
                      ),
                    ),
                    //ElevatedButton(onPressed: (){ print('pressed'); httpModel().testCreateArticle(); }, child: const Text('TestArticle')),
                    //ElevatedButton(onPressed: (){ print('logout'); httpModel().testLogout(); }, child: const Text('TestLogout')),
                  ].map((element){
                    return Container(margin: const EdgeInsets.only(bottom: 10) ,child: element,);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class LoginViewModel{

  Future<bool> ManualLogin() async {
    print('login tried');
    return await true;//httpModel().testLogin();
  }

  void AutoLogin(){

  }
}