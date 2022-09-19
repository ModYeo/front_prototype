import 'package:flutter/material.dart';
import 'package:unnamed_project/home/crew/crew_list.dart';
import 'package:unnamed_project/home/crew/crew_apply_page.dart';
import 'package:unnamed_project/models/crew.dart';

class CrewHome extends StatelessWidget {
  const CrewHome({Key? key, required this.navigator}) : super(key: key);

  final GlobalKey<NavigatorState> navigator;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigator,
      initialRoute: '/crew_main',
      onGenerateRoute: (RouteSettings settings){
        WidgetBuilder builder;

        switch(settings.name){
          case '/crew_main': builder = (context) =>
              CrewMainView(
                onChangePage: pushCrewListView,
                onMyCrewView: pushMyCrewView,
                onRecommendedCrewView: pushRecommededCrewView,
              ); break;
          case '/crew_list' : builder = (context) => CrewListView(); break;
          case '/signup': builder = (context) => Container(); break;
          default :builder = (context) => Text('error'); break;
        }
        return MaterialPageRoute(builder: builder);
      }
    );
  }

  void pushCrewListView(){
    print('pushed');
    navigator.currentState?.pushNamed('/crew_list');
  }

  void pushMyCrewView(){
    navigator.currentState?.push(MaterialPageRoute(builder: (context) => Container()));
  }

  void pushRecommededCrewView(){
    navigator.currentState?.push(MaterialPageRoute(builder: (context) => Container()));
  }
}

class CrewMainView extends StatefulWidget {
  const CrewMainView({
    Key? key,
    required this.onChangePage,
    required this.onMyCrewView,
    required this.onRecommendedCrewView
  }) : super(key: key);

  final VoidCallback onChangePage;
  final VoidCallback onMyCrewView;
  final VoidCallback onRecommendedCrewView;

  @override
  State<CrewMainView> createState() => _CrewMainViewState();
}

class _CrewMainViewState extends State<CrewMainView> {

  late TextEditingController _searchTextController;

  late List<Crew> _myCrewList;
  late List<Crew> _recommendedCrewList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchTextController = TextEditingController();
    _myCrewList = CrewMainViewModel().getMyCrews();
    _recommendedCrewList = CrewMainViewModel().getRecommendedCrews();
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
          pinned: true,
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            children: [
              Padding(
                padding : EdgeInsets.only(top : MediaQuery.of(context).padding.top),
                child: SizedBox(
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
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Theme.of(context).colorScheme.secondary
            ),
            child: Column(
              children: [
                Align(
                    alignment: Alignment(-0.9,0),
                    child: Text('Crews')
                ),
                SizedBox(
                  height: 100,
                  child: ((_myCrewList.isEmpty)?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('no crews'),
                      ElevatedButton(onPressed: (){ widget.onChangePage(); }, child: Text('create crews'))
                    ],
                  ) :
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index){
                      return MyCrewListTile(crew : _myCrewList[index]);
                    },
                  )
                  ),
                )
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Text('Recommended Crews'),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index){
              return CrewListTile(data : _recommendedCrewList[index]);
            },
              childCount: 20,
            )
        )
      ],
    );
  }
}

class MyCrewListTile extends StatelessWidget {
  const MyCrewListTile({Key? key, required this.crew}) : super(key: key);

  final Crew crew;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction : Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
          ),
          height: 50,
          width: 50,
        ),
        Text(crew.getName)
      ],
    );
  }
}

class CrewListTile extends StatelessWidget {
  const CrewListTile({Key? key, required this.data}) : super(key: key);

  final Crew data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){ Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context) => CrewApplyPageView())); },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Container(
            color: Theme.of(context).colorScheme.tertiary,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Text('image'),
                ),
                Column(
                  children: [
                    Text(data.getName),
                    Text('category')
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}

class CrewMainViewModel{
  List<Crew> getMyCrews(){
    return List.empty();//List.generate(4, (index) => Crew('crewname my$index', 'path'));
  }

  List<Crew> getRecommendedCrews(){
    return List.generate(20, (index) => Crew('crewname $index', 'imagepath'));
  }
}
