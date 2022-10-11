import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnamed_project/route_navigator/login_route_navigator.dart';
import 'package:unnamed_project/route_navigator/route_navigator.dart';
import 'package:unnamed_project/view_model.dart';

class AuthenticatePageView extends StatelessWidget {
  AuthenticatePageView({Key? key}) : super(key: key);
  late AuthenticatePageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<AuthenticatePageViewModel>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: viewModel.authForm,
            child: ListView(
              children: [
                Text('Self-Authenticate'),
                Text('input your Email address.'),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  controller: viewModel.emailText,
                  validator: viewModel.validator,
                  //textInputAction: TextInputAction.next,
                ),
                ElevatedButton(onPressed: (){}, child: Text('Send Code')),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Code',
                  ),
                  controller: viewModel.confirmText,
                  validator: viewModel.validator,
                  //textInputAction: TextInputAction.next,
                ),
                ElevatedButton(
                    onPressed: (){
                      if(viewModel.authenticateEmail())
                        viewModel.navigateToSignup();
                    },
                    child: Text('Confirm Code')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class AuthenticatePageViewModel extends ViewModel{

  final authForm = GlobalKey<FormState>();

  final emailText = TextEditingController();
  final confirmText = TextEditingController();

  AuthenticatePageViewModel(super.context);

  void navigateToSignup() => RouteNavigator().login.pushReplacementNamed(LoginRoute.Signup.path);

  String? validator(text){
    if(text == null || text.isEmpty) {
      return 'Input required.';
    }
    else {
      return null;
    }
  }

  bool authenticateEmail(){
    return authForm.currentState!.validate();
  }
}
