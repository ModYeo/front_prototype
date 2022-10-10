import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unnamed_project/http_model/httpModel.dart';
import 'package:unnamed_project/regex.dart';
import 'package:unnamed_project/route_navigator/route_navigator.dart';

import '../models/user.dart';
import '../view_model.dart';

class SignupPageView extends StatelessWidget {
  SignupPageView({Key? key}) : super(key: key);
  late SignupPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<SignupPageViewModel>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: ListView(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child : Form(
                  key: viewModel.signupForm,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: [
                    inputPassword(),
                    inputNickname(),
                    inputSex(),
                    inputBirthday(),
                    inputRegion(),
                    inputForm()
                  ][viewModel.inputOrder],
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomButtons(){
    return Row(
      children: [
        viewModel.inputOrder > 0 ? ElevatedButton(
            onPressed: (){
              viewModel.toPrev();
            },
            child: Text('Back')
        ) : SizedBox(),
        ElevatedButton(
            onPressed: (){
              if(viewModel.signupForm.currentState!.validate()){
                viewModel.signupForm.currentState!.save();
                viewModel.toNext();
              }
            },
            child: Text('Next')
        )
      ],
    );
  }

  Widget inputPassword(){
    return Wrap(
      children: [
        Wrap(
          children: [
            Text('Password'),
            Stack(
                children : [
                  TextFormField(
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(16)
                    ],
                    obscureText: viewModel.obscurePassword,
                    keyboardType: TextInputType.visiblePassword,
                    controller: viewModel.pwTextController,
                    textInputAction: TextInputAction.next,
                    validator: viewModel.passwordValidator,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: IconButton( onPressed: (){}, icon: Icon(Icons.remove_red_eye),),
                  )
                ]
            ),
          ],
        ),
        Wrap(
          children: [
            Text('Confirm Password'),
            TextFormField(
              inputFormatters: [
                new LengthLimitingTextInputFormatter(16)
              ],
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              controller: viewModel.pwCheckTextController,
              textInputAction: TextInputAction.next,
              validator: viewModel.passwordCheckValidator,
            ),
          ],
        ),
        bottomButtons()
      ],
    );
  }

  Widget inputNickname(){
    return Column(
      children: [
        Wrap(
          children: [
            Text('Nickname'),
            TextFormField(
              keyboardType: TextInputType.name,
              inputFormatters: [
                new LengthLimitingTextInputFormatter(16)
              ],
              decoration: const InputDecoration(
                hintText: 'Input Nickname',
              ),
              controller: viewModel.nickNameTextController,
              textInputAction: TextInputAction.next,
              validator: viewModel.nicknameCheckValidator,
            ),
          ],
        ),
        bottomButtons()
      ],
    );
  }

  Widget inputSex(){
    return Column(
      children: [
        Wrap(
          children: [
            Text('Sex'),
            DropdownButtonFormField<UserSex>(
                value: viewModel.userSex,
                items: UserSex.values.map<DropdownMenuItem<UserSex>>((UserSex value) => (
                    DropdownMenuItem<UserSex>(
                        value : value,
                        child : Text(value.name.toString())
                    ))
                ).toList(),
                onChanged: (value){
                  viewModel.userSex = value!;
                }
            ),
          ],
        ),
        bottomButtons()
      ],
    );
  }

  Widget inputBirthday(){
    return Wrap(
      children: [
        Text('Birthday'),
        TextFormField(
          keyboardType: TextInputType.datetime,
          decoration: const InputDecoration(
            hintText: 'Input Birthday',
          ),
          controller: viewModel.birthdayTextController,
          textInputAction: TextInputAction.next,
          validator: viewModel.birthdayCheckValidator,
        ),
        bottomButtons()
      ],
    );
  }

  Widget inputRegion(){
    return Container(
      child: Column(
        children: [
          Wrap(
            children: [
              Text('Region'),
              Row(
                children: [
                  Flexible(
                    flex: 30,
                    child: DropdownButtonFormField<UserSex>(
                        value: viewModel.userSex,
                        items: UserSex.values.map<DropdownMenuItem<UserSex>>((UserSex value) => (
                            DropdownMenuItem<UserSex>(
                                value : value,
                                child : Text(value.name.toString())
                            ))
                        ).toList(),
                        onChanged: (value){viewModel.userSex = value;}
                    ),
                  ),
                  Spacer(flex: 1,),
                  Flexible(
                    flex: 30,
                    child: DropdownButtonFormField<UserSex>(
                        value: viewModel.userSex,
                        items: UserSex.values.map<DropdownMenuItem<UserSex>>((UserSex value) => (
                            DropdownMenuItem<UserSex>(
                                value : value,
                                child : Text(value.name.toString())
                            ))
                        ).toList(),
                        onChanged: (value){viewModel.userSex = value;}
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomButtons()
        ],
      ),
    );
  }

  Widget inputForm(){
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(value: viewModel.agreeUsageOfPrivateInfo, onChanged: (value){ viewModel.agreeUsageOfPrivateInfo = value; }),
                Text('Private'),
                TextButton(onPressed: (){}, child: Text('more info'))
              ],
            ),
          ),
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(value: viewModel.agreeMarketingAcceptance, onChanged: (value){ viewModel.agreeMarketingAcceptance = value;}),
                Text('Marketing Acceptance'),
                TextButton(onPressed: (){}, child: Text('more info'))
              ],
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                final response = await viewModel.doSignup();
                print(response);
                RouteNavigator().login.pop();
              },
              child: const Text('Signup')
          ),
        ],
      ),
    );
  }

}

class SignupPageViewModel extends ViewModel{
  SignupPageViewModel(super.context);

  final signupForm = GlobalKey<FormState>();

  TextEditingController pwTextController = TextEditingController();
  TextEditingController pwCheckTextController = TextEditingController();
  TextEditingController nickNameTextController = TextEditingController();
  TextEditingController birthdayTextController = TextEditingController();

  bool _agreeUsageOfPrivateInfo = false;
  bool _agreeMarketingAcceptance = false;

  UserSex _userSex = UserSex.MALE;

  bool _obscurePassword = true;

  int _inputOrder = 0;

  int get inputOrder => _inputOrder;

  bool get agreeUsageOfPrivateInfo => _agreeUsageOfPrivateInfo;
  set agreeUsageOfPrivateInfo(value){ _agreeUsageOfPrivateInfo = value; }
  bool get agreeMarketingAcceptance => _agreeMarketingAcceptance;
  set agreeMarketingAcceptance(value){ _agreeMarketingAcceptance = value; }

  UserSex get userSex => _userSex;
  set userSex(userSex){ _userSex = userSex; notifyListeners(); }

  bool get obscurePassword => _obscurePassword;
  set obscurePassword(value){ _obscurePassword = value; }

  void toggleObscure(){
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void toPrev(){
    if(_inputOrder > 1)
      _inputOrder--;
    else
      _inputOrder = 0;
    notifyListeners();
  }

  void toNext(){
    _inputOrder++;
    notifyListeners();
  }

  Future<bool> doSignup() async {
    print('start signup');
    return await httpModel().testSignup();
  }

  String? passwordValidator(text){
    if(text == null || text.isEmpty){
      return 'Input required.';
    }
    else if(!validatePassword(text)){
      return 'Invalid password';
    }
    else{
      return null;
    }
  }

  String? passwordCheckValidator(text){
    if(text == null || text.isEmpty){
      return 'Input required.';
    }
    else if(pwTextController.value != pwCheckTextController.value){
      return 'Password is not the same';
    }
    else {
      return null;
    }
  }

  String? nicknameCheckValidator(text){
    if(text == null || text.isEmpty){
      return 'Input required.';
    }
    else if(!validateNickname(text)){
      return 'Invalid nickname';
    }
    else{
      return null;
    }
  }

  String? birthdayCheckValidator(text){
    if(text == null || text.isEmpty){
      return 'Input required.';
    }
    else if(text.length < 8){
      return 'Invalid Datetime';
    }
    else{
      try{
        var date = DateTime.parse(text);
      }
      catch(e){
        return 'Datetime format invalid';
      }
      return null;
    }
  }
}
