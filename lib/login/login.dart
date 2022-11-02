import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnamed_project/route_navigator/login_route_navigator.dart';
import 'package:unnamed_project/route_navigator/root_route_navigator.dart';
import 'package:unnamed_project/route_navigator/route_navigator.dart';
import 'package:unnamed_project/view_model.dart';

import '../http_model/httpModel.dart';
import '../secure_storage/storageModel.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: RouteNavigator().login.ReturnRoute,
      child: Navigator(
        onPopPage: (route, _) { print('pushed'); return false; },
        key: RouteNavigator().login.navKey,
        initialRoute: LoginRoute.Login.path,
        onGenerateRoute: RouteNavigator().login.PathRoute
      ),
    );
  }
}

class LoginPageView extends StatelessWidget {
  LoginPageView({Key? key}) : super(key: key);

  final idTextController = TextEditingController();
  final pwTextController = TextEditingController();

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
                          controller: idTextController,
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
                          controller: pwTextController,
                          onSubmitted: (text){},
                          textInputAction: TextInputAction.next,
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 30,
                    //   width: 200,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Checkbox(value: viewModel.enableIDSave, onChanged: (value){ viewModel.toggleIDSave(); }),
                    //       Text('Save ID')
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => FutureBuilder(
                              future: Future.delayed(Duration(seconds: 2), () => true)//viewModel.ManualLogin("test@gmail.com", "test123")
                                  .then((value){
                                if(value == true)
                                  RouteNavigator().root.pushReplacementNamed(RootRoute.Home.path);
                                return value;
                              }),
                              builder: (context, snapshot){
                                if(snapshot.hasData && snapshot.data == false){
                                  return LoginPageViewDialog();
                                }
                              return Center(child: CircularProgressIndicator(),);
                            })
                          );
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

  bool enableIDSave = false;

  List<int>? testList;

  LoginPageViewModel(context) : super(context){
    getList();
  }

  void navigateToHome() => RouteNavigator().root.pushReplacementNamed(RootRoute.Home.path);
  void navigateToSignup() => RouteNavigator().login.pushNamed(LoginRoute.Authenticate.path);

  void toggleIDSave(){
    enableIDSave = !enableIDSave;
    notifyListeners();
  }

  Future<bool> ManualLogin(id, pw) async {
    var response = await httpModel().login(id, pw);
    if(response){
      await StorageModel().save('id', id);
      await StorageModel().save(id, base64Encode(utf8.encode('$id:$pw')));
    }
    return false;
  }

  Future<bool> AutoLogin() async {
    var id, pw;
    if(id = await StorageModel().read('id') != null && (pw = await StorageModel().read(id)) != null){
      return await httpModel().login(id, pw);
    }
    return false;
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
