import 'package:flutter/material.dart';

class AuthenticatePageView extends StatefulWidget {
  const AuthenticatePageView({Key? key}) : super(key: key);

  @override
  State<AuthenticatePageView> createState() => _AuthenticatePageViewState();
}

class _AuthenticatePageViewState extends State<AuthenticatePageView> {

  late TextEditingController _emailTextController;
  late TextEditingController _codeTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _codeTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _codeTextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              Text('Self-Authenticate'),
              Text('input your Email address.'),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                controller: _emailTextController,
                onSubmitted: (text){},
                //textInputAction: TextInputAction.next,
              ),
              ElevatedButton(onPressed: (){}, child: Text('Send Code')),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Code',
                ),
                controller: _codeTextController,
                onSubmitted: (text){},
                //textInputAction: TextInputAction.next,
              ),
              ElevatedButton(onPressed: (){ Navigator.pushReplacementNamed(context, '/signup');}, child: Text('Confirm Code')),
            ],
          ),
        ),
      ),
    );
  }
}
