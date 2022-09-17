import 'package:flutter/material.dart';

class CrewPageView extends StatelessWidget {
  const CrewPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crew Name'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context){
              return [
                PopupMenuItem(child: Text('first'))
              ];
            },
          ),
        ]
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                )
              ],
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(
            [
              Text('content'),
              Container(
                child: Text('text'),
              ),
              ElevatedButton(onPressed: (){}, child: Text('confirm'))
            ]
          )),
        ],
      ),
    );
  }
}
