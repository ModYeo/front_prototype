import 'package:flutter/material.dart';
import 'package:unnamed_project/home/alarm/alarm.dart';
import 'package:unnamed_project/home/board.dart';
import 'package:unnamed_project/models/post.dart';

class HomeBoardView extends StatefulWidget {
  const HomeBoardView({Key? key}) : super(key: key);

  @override
  State<HomeBoardView> createState() => _HomeBoardViewState();
}

class _HomeBoardViewState extends State<HomeBoardView> {
  late TextEditingController _searchTextController;

  var _dropdownList = ['one', 'two', 'three'];
  var _dropdownValue;

  late List<PostData> _postList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postList = HomeBoardViewModel().getPosts();
    _searchTextController = TextEditingController();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          controller: _searchTextController,
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
                          value: _dropdownValue,
                          hint: Text(_dropdownValue??'none'),
                          underline: null,
                          onChanged: (value){ setState((){_dropdownValue = value;});},
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          items: _dropdownList.map<DropdownMenuItem<String>>((value) => DropdownMenuItem(value : value, child: Text(value))).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index){
              return BoardListTile(data : _postList[index]);
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

class HomeBoardViewModel{

  List<PostData> getPosts(){
    return List.generate(20, (index) => PostData(PostInfo(index, 0), 'title', 'content', 0, 0, 0));
  }

}