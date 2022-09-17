import 'package:flutter/material.dart';
import 'package:unnamed_project/http_model/httpModel.dart';
import 'package:unnamed_project/theme/style.dart';

import '../models/user.dart';


class SignupPageView extends StatefulWidget {
  const SignupPageView({Key? key}) : super(key: key);

  @override
  State<SignupPageView> createState() => _SignupPageViewState();
}

class _SignupPageViewState extends State<SignupPageView> {

  final _signupForm = GlobalKey<FormState>();

  UserSex userSex = UserSex.MALE;

  late TextEditingController _idTextController;
  late TextEditingController _pwTextController;
  late TextEditingController _pwCheckTextController;
  late TextEditingController _nickNameTextController;

  bool _agreeUsageOfPrivateInfo = false;
  bool _agreeMarketingAcceptance = false;

  @override
  void initState(){
    super.initState();
    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();
    _pwCheckTextController = TextEditingController();
    _nickNameTextController = TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _idTextController.dispose();
    _pwTextController.dispose();
    _pwCheckTextController.dispose();
    _nickNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child : Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
                    constraints: const BoxConstraints(maxHeight: 40)
                  )
                ),
                child: Form(
                  key: _signupForm,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 5,
                    children: [
                      Container(
                        height: 60,
                        child: Text('Logo'),
                      ),
                      Wrap(
                        children: [
                          Text('Email'),
                          TextFormField(
                            controller: _idTextController,
                            textInputAction: TextInputAction.next,
                            validator: (text){
                              return (text == null || !text.contains('@')) ? 'Email invalid' : null;
                            },
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          Text('Password'),
                          TextFormField(
                            controller: _pwTextController,
                            textInputAction: TextInputAction.next,
                            validator: (text){

                            },
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          Text('Confirm Password'),
                          TextFormField(
                            controller: _pwCheckTextController,
                            textInputAction: TextInputAction.next,
                            validator: (text){

                            },
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          Text('Nickname'),
                          TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Input Nickname',
                            ),
                            controller: _nickNameTextController,
                            textInputAction: TextInputAction.next,
                            validator: (text){

                            },
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          Text('Sex'),
                          DropdownButtonFormField<UserSex>(
                            value: userSex,
                            items: UserSex.values.map<DropdownMenuItem<UserSex>>((UserSex value) => (
                                DropdownMenuItem<UserSex>(
                                    value : value,
                                    child : Text(value.name.toString())
                                ))
                            ).toList(),
                            onChanged: (value){
                              setState((){
                                userSex = value!;
                              });
                            }
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          Text('Birthday'),
                          Row(
                            children: [
                              Flexible(
                                flex : 30,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'Year',
                                  ),
                                  controller: _nickNameTextController,
                                  textInputAction: TextInputAction.next,
                                  validator: (text){

                                  },
                                ),
                              ),
                              const Spacer(flex: 1,),
                              Flexible(
                                flex : 20,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'MM',
                                  ),
                                  controller: _nickNameTextController,
                                  textInputAction: TextInputAction.next,
                                  validator: (text){

                                  },
                                ),
                              ),
                              const Spacer(flex: 1,),
                              Flexible(
                                flex : 20,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: 'DD',
                                  ),
                                  controller: _nickNameTextController,
                                  textInputAction: TextInputAction.next,
                                  validator: (text){

                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Wrap(
                        children: [
                          Text('Region'),
                          Row(
                            children: [
                              Flexible(
                                flex: 30,
                                child: DropdownButtonFormField<UserSex>(
                                    value: userSex,
                                    items: UserSex.values.map<DropdownMenuItem<UserSex>>((UserSex value) => (
                                        DropdownMenuItem<UserSex>(
                                            value : value,
                                            child : Text(value.name.toString())
                                        ))
                                    ).toList(),
                                    onChanged: (value){
                                      setState((){
                                        userSex = value!;
                                      });
                                    }
                                ),
                              ),
                              Spacer(flex: 1,),
                              Flexible(
                                flex: 30,
                                child: DropdownButtonFormField<UserSex>(
                                    value: userSex,
                                    items: UserSex.values.map<DropdownMenuItem<UserSex>>((UserSex value) => (
                                        DropdownMenuItem<UserSex>(
                                            value : value,
                                            child : Text(value.name.toString())
                                        ))
                                    ).toList(),
                                    onChanged: (value){
                                      setState((){
                                        userSex = value!;
                                      });
                                    }
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(value: _agreeUsageOfPrivateInfo, onChanged: (value){setState((){_agreeUsageOfPrivateInfo = value!;});}),
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
                            Checkbox(value: _agreeMarketingAcceptance, onChanged: (value){setState((){_agreeMarketingAcceptance = value!;});}),
                            Text('Marketing Acceptance'),
                            TextButton(onPressed: (){}, child: Text('more info'))
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final response = await SignupPageViewModel().doSignup();
                          print(response);
                          Navigator.pop(context);
                        },
                        child: const Text('Signup')
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupPageViewModel{
  getRegion(){

  }

  Future<bool> doSignup() async {
    print('start signup');
    return await httpModel().testSignup();
  }
}