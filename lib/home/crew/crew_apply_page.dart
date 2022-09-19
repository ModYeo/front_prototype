import 'package:flutter/material.dart';
import 'package:unnamed_project/home/crew/crew_home.dart';
import 'package:unnamed_project/home/crew/crew_main_page.dart';

class CrewApplyPageView extends StatelessWidget {
  const CrewApplyPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crew Name'),
        actions: [
          PopupMenuButton(
            onSelected: (index){ Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => CrewMainPageView())); },
            itemBuilder: (context){
              return [
                PopupMenuItem(value : 0, child: Text('first'))
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
