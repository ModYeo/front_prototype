import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnamed_project/route_navigator/route_navigator.dart';
import 'package:unnamed_project/view_model.dart';

import '../http_model/httpModel.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: RouteNavigator().LoginPathReturnRoute,
      child: Navigator(
        onPopPage: (route, _) { print('pushed'); return false; },
        key: RouteNavigator().login.navKey,
        initialRoute: LoginRoute.Login.path,
        onGenerateRoute: RouteNavigator().LoginPathRoute
      ),
    );
  }
}

class LoginPageView extends StatelessWidget {
  LoginPageView({Key? key}) : super(key: key);

  late LoginPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<LoginPageViewModel>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SizedBox(
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
                          controller: viewModel.idTextController,
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
                          obscureText: true,
                          controller: viewModel.pwTextController,
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
                          Checkbox(value: viewModel.enableIDSave, onChanged: (value){ viewModel.toggleIDSave(); }),
                          Text('Save ID')
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(await viewModel.ManualLogin()){
                            viewModel.navigateToHome();
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                          onPressed: viewModel.navigateToSignup,
                          child: const Text('SignUp')
                      ),
                    ),
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

class LoginPageViewModel extends ViewModel{
  late TextEditingController idTextController;
  late TextEditingController pwTextController;

  bool enableIDSave = false;

  List<int>? testList;

  LoginPageViewModel(context) : super(context){
    idTextController = TextEditingController();
    pwTextController = TextEditingController();
    getList();
  }

  void navigateToHome() => RouteNavigator().root.pushReplacementNamed(RootRoute.Home.path);
  void navigateToSignup() => RouteNavigator().login.pushNamed(LoginRoute.Authenticate.path);

  void toggleIDSave(){
    enableIDSave = !enableIDSave;
    notifyListeners();
  }

  Future<bool> ManualLogin() async {
    print('login tried');
    return await httpModel().testLogin();
  }

  Future<void> getList() async{
    await Future.delayed(Duration(seconds: 2));
    testList = List.generate(5, (index) => index);
    notifyListeners();
    print('something');
  }

  String listLength(){
    if(testList == null)
      return '0';
    else
      return testList!.length.toString();
  }

  void showAlertDialog(){
    showDialog(context: context, builder: (context) => LoginPageViewDialog());
  }
}

class LoginPageViewDialog extends StatelessWidget {
  const LoginPageViewDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: const Text('AlertDialog description'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
