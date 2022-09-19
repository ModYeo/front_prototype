import 'package:flutter/material.dart';
import 'package:unnamed_project/home/home_board.dart';
import 'package:unnamed_project/models/post.dart';

class CrewMainPageView extends StatefulWidget {
  const CrewMainPageView({Key? key}) : super(key: key);

  @override
  State<CrewMainPageView> createState() => _CrewMainPageViewState();
}

class _CrewMainPageViewState extends State<CrewMainPageView> {

  var _dropdownValue;
  var _dropdownList = { ' ' };
  late List<PostData> _postList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postList = CrewMainPageViewModel().getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CrewName'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
                    ),
                    child: Text('Notice'),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25))
                    ),
                    child: Row(
                      children: [
                        Container(
                          child: Text('Notice content'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            title: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _dropdownValue,
                hint: Text(_dropdownValue??'none'),
                underline: null,
                onChanged: (value){ setState((){_dropdownValue = value;});},
                borderRadius: BorderRadius.all(Radius.circular(20)),
                items: _dropdownList.map<DropdownMenuItem<String>>((value) => DropdownMenuItem(value : value, child: Text(value))).toList(),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => BoardListTile(data: _postList[index]),
              childCount: 20
            ),
          )
        ],
      ),
    );
  }
}

class CrewMainPageViewModel{

  List<PostData> getPosts(){
    return List.generate(20, (index) => PostData(PostInfo(index, 0), 'title', 'content', 0, 0, 0));
  }

}