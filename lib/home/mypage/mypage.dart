import 'package:flutter/material.dart';

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
              Text('Username')
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Text('My Activity'),
        ),
        TextButton.icon(
          onPressed: ( ){},
          icon: Icon(Icons.thumb_up),
          label: Row(
            children: [
              Text('likes'),
              Spacer()
            ],
          ),
        ),
      ],
    );
  }
}
