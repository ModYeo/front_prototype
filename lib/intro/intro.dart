import 'package:flutter/material.dart';
import 'package:unnamed_project/http_model/httpModel.dart';
import 'package:unnamed_project/login/login.dart';

import '../secure_storage/storageModel.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  Future<bool> _delayOpening() async {
    await Future.delayed(const Duration(seconds: 1), );

    var data = await StorageModel().readAll();
    if(data.containsKey('id') && data.containsKey('pw')){
      var id = data['id'];
      var pw = data['pw'];
      if(await httpModel().login(id, pw)){
      return true;
      }
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _delayOpening();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _delayOpening(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Login();
          } else if(snapshot.hasError){
            print('error');
          }
          return Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}
