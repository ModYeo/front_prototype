import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnamed_project/home/alarm/alarm.dart';
import 'package:unnamed_project/home/board.dart';
import 'package:unnamed_project/models/post.dart';

import '../view_model.dart';

class HomePageView extends StatelessWidget {
  HomePageView({Key? key}) : super(key: key);
  late HomePageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<HomePageViewModel>(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('TimeLine'),
              Spacer(),
              IconButton(onPressed: (){ Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => AlarmView())); }, icon: Icon(Icons.notifications))
            ],
          ),
        ),
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          collapsedHeight: 100,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top : MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: viewModel.searchTextController,
                        ),
                      ),
                      IconButton(onPressed: (){}, icon: Icon(Icons.search))
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
                      Spacer(),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: viewModel.dropdownValue,
                          hint: Text(viewModel.dropdownValue),
                          underline: null,
                          onChanged: (value){ viewModel.dropdownValue = value; },
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          items: viewModel.dropdownList.map<DropdownMenuItem<String>>((value) => DropdownMenuItem(value : value, child: Text(value))).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        viewModel.postList.isEmpty ?
        CircularProgressIndicator(

        ) :
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index){
              return BoardListTile(data : viewModel.postList[index]);
            },
              childCount: 20,
            )
        )
      ],
    );
  }
}

class BoardListTile extends StatelessWidget {
  const BoardListTile({Key? key, required this.data}) : super(key: key);

  final PostData data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => BoardView())); },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Container(
          color: Theme.of(context).colorScheme.tertiary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('title'),
                    Container(
                        padding: EdgeInsets.all(10),
                        child: Text('content')
                    ),
                  ],
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.primary,
                child: Row(
                  children:[
                    Icon(Icons.remove_red_eye),
                  ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageViewModel extends ViewModel{
  HomePageViewModel(super.context);

  late TextEditingController searchTextController;

  final List _dropdownList = ['one', 'two', 'three'];
  late String _dropdownValue;

  late List<PostData> _postList;

  List get dropdownList => _dropdownList;
  String get dropdownValue => _dropdownValue;
  set dropdownValue(value){ _dropdownValue = value; }

  List<PostData> get postList => _postList;

  Future<List<PostData>> getPosts() async {
    return List.generate(20, (index) => PostData(PostInfo(index, 0), 'title', 'content', 0, 0, 0));
  }

}