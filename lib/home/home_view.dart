import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnamed_project/custom_components/sliver_refresh_control.dart';
import 'package:unnamed_project/home/alarm/alarm.dart';
import 'package:unnamed_project/home/board.dart';
import 'package:unnamed_project/models/post.dart';

import '../custom_components/custom_lazy_scroll.dart';
import '../view_model.dart';

class HomePageView extends StatelessWidget {
  HomePageView({Key? key}) : super(key: key);
  late HomePageViewModel viewModel;

  final scrollController = ScrollController();
  final searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<HomePageViewModel>(context);
    print('build');
    return Stack(
      children: [
        CustomLazyScrollView(
          onReachEnd: () async { await viewModel.getNewPosts(); print('end'); return Future(() => null); },
          controller: scrollController,
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                              controller: searchTextController,
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
                          AsyncCategoryDropdown(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomSliverRefreshControl(onRefresh: viewModel.refreshPosts),
            AsyncBoardList(),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: FloatingActionButton(onPressed: (){

            })
          )
        )
      ],
    );
  }

  Widget AsyncCategoryDropdown(){
    return FutureBuilder(
      future: viewModel.getCategory(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          print('dropdown:' + viewModel.dropdownValue);
          return DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: viewModel.dropdownValue,
              hint: Text(viewModel.dropdownValue),
              underline: null,
              onChanged: (value){ viewModel.dropdownValue = value; },
              borderRadius: BorderRadius.all(Radius.circular(20)),
              items: viewModel.dropdownList.map<DropdownMenuItem<String>>((value) => DropdownMenuItem(value : value, child: Text(value))).toList(),
            ),
          );
        }
        else{
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget AsyncBoardList(){
    return FutureBuilder(
        future: viewModel.getPosts(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return SliverList(
                delegate: SliverChildBuilderDelegate((context, index){
                  return BoardListTile(data : viewModel.postList[index]);
                },
                  childCount: viewModel.postList.length,
                )
            );
          }
          else{
            return SliverToBoxAdapter(child: CircularProgressIndicator());
          }
        }
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
  HomePageViewModel(context) : super(context);

  late List _dropdownList;
  late String _dropdownValue;

  final List<PostData> _postList = <PostData>[];

  List get dropdownList => _dropdownList;
  String get dropdownValue => _dropdownValue;
  set dropdownValue(value){ _dropdownValue = value; notifyListeners(); print(dropdownValue); }

  List<PostData> get postList => _postList;

  Future getCategory() async {
    _dropdownList = ['one', 'two', 'three'];
    _dropdownValue = _dropdownList[0];
    await Future.delayed(const Duration(seconds: 2));
    return 'finish';
  }

  Future refreshPosts() async {
    print('refresh');
    return Future.delayed(Duration(seconds: 2));
  }
  
  Future getPosts() async {
    _postList.addAll(List.generate(20, (index) => PostData(PostInfo(index, 0), 'title$index', 'content', 0, 0, 0)));
    return 'finish';
  }

  Future getNewPosts() async {
    await Future.delayed(Duration(seconds: 1));
    _postList.addAll(List.generate(20, (index) => PostData(PostInfo(index, 0), 'title$index', 'content', 0, 0, 0)));
    notifyListeners();
    return 'finish';
  }

}