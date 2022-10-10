import 'package:flutter/material.dart';
import 'package:unnamed_project/home/mypage/profile_edit_page.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Theme.of(context).colorScheme.primary,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Placeholder(
                fallbackHeight: 50,
                fallbackWidth: 50,
              ),
              Text('Username'),
              Spacer(),
              IconButton(onPressed: (){ Navigator.of(context).push( MaterialPageRoute(builder: (context) => ProfileEditPageView())); }, icon: Icon(Icons.navigate_next))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Text('My Activity'),
        ),
        Material(
          child: ListTile(
            tileColor: Colors.green,
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: (){
              Navigator.of(context, rootNavigator: true).pushReplacementNamed('/login');
            },
          ),
        )
      ],
    );
  }
}
