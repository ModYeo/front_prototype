import 'package:flutter/material.dart';
import 'package:unnamed_project/home/crew/crew_home.dart';
import 'package:unnamed_project/models/crew.dart';

class CrewListView extends StatefulWidget {
  const CrewListView({Key? key}) : super(key: key);

  @override
  State<CrewListView> createState() => _CrewListViewState();
}

class _CrewListViewState extends State<CrewListView> {

  late List<Crew> _myManagingCrews;
  late List<Crew> _myJoinedCrews;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myManagingCrews = CrewListViewModel().getManagingCrews();
    _myJoinedCrews = CrewListViewModel().getJoinedCrews();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(),
        SliverToBoxAdapter(
          child: Column(
            children:[
              Text("Create your own crew!\nInvide your friends!\nRecruit 5 people"),
              ElevatedButton(onPressed: (){}, child: Text('create crew'))
            ]
          ),
        ),
        SliverToBoxAdapter(
          child: Text('Managing Crews'),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index){
            return CrewListTile(data : _myManagingCrews[index]);
            },
            childCount: _myManagingCrews.length
          )
        ),
        SliverToBoxAdapter(
          child: Text('Joined Crews'),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index){
              return CrewListTile(data : _myJoinedCrews[index]);
            },
                childCount: _myJoinedCrews.length
            )
        )
      ],
    );
  }
}

class CrewListViewModel{
  List<Crew> getManagingCrews(){
    return List.generate(2, (index) => Crew('my managing crew $index', 'path'));
  }

  List<Crew> getJoinedCrews(){
    return List.generate(5, (index) => Crew('my joined crew $index', 'path'));
  }
}
