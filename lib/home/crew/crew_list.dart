import 'package:flutter/material.dart';
import 'package:unnamed_project/home/crew/crew_home.dart';
import 'package:unnamed_project/models/crew.dart';
import 'package:unnamed_project/view_model.dart';

class CrewListView extends StatelessWidget {
  CrewListView({Key? key}) : super(key: key);
  late CrewListViewModel viewModel;

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
              return CrewListTile(data : viewModel.myManagingCrews[index]);
            },
                childCount: viewModel.myManagingCrews.length
            )
        ),
        SliverToBoxAdapter(
          child: Text('Joined Crews'),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index){
              return CrewListTile(data : viewModel.myJoinedCrews[index]);
            },
                childCount: viewModel.myJoinedCrews.length
            )
        )
      ],
    );
  }
}

class CrewListViewModel extends ViewModel{

  late List<Crew> myManagingCrews;
  late List<Crew> myJoinedCrews;

  CrewListViewModel(super.context){
    getManagingCrews();
    getJoinedCrews();
  }

  Future<void> getManagingCrews() async {
    await Future.delayed(Duration(seconds: 2));
    myManagingCrews = List.generate(2, (index) => Crew('my managing crew $index', 'path'));
  }

  Future<void> getJoinedCrews() async {
    await Future.delayed(Duration(seconds: 2));
    myJoinedCrews =  List.generate(5, (index) => Crew('my joined crew $index', 'path'));
  }

  @override
  dispose() {
    // TODO: implement dispose
    throw UnimplementedError();
  }
}
