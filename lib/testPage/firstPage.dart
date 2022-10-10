import 'package:flutter/material.dart';
import 'package:unnamed_project/testPage/mainpage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  late TextEditingController idTextController;
  late TextEditingController pwTextController;

  void ManualLogin(){
    Navigator.pushNamed(context, '/login');
  }

  void AutoLogin(){

  }

  void ManualSignUp(){

  }

  @override
  void initState(){
    super.initState();
    idTextController = TextEditingController();
    pwTextController = TextEditingController();
    AutoLogin();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    idTextController.dispose();
    pwTextController.dispose();
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
                child: Text('icon'),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                color: const Color.fromRGBO(227, 235, 222, 1.0),
                padding: const EdgeInsets.all(10),
                child : Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(200, 75)),
                      child: TextField(
                        decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'ID',
                            labelText: 'Input your ID'
                        ),
                        controller: idTextController,
                        onSubmitted: (text){},
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tight(const Size(200, 75)),
                      child: TextField(
                        decoration: const InputDecoration(
                            icon: Icon(Icons.password),
                            hintText: 'PW',
                            labelText: 'Input your password'
                        ),
                        controller: pwTextController,
                        onSubmitted: (text){},
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    ElevatedButton(onPressed: (){ ManualLogin(); }, child: const Text('Login')),
                    ElevatedButton(onPressed: (){ ManualSignUp(); }, child: const Text('SignUp')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
