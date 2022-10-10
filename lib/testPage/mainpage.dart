import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Pages {
  firstPage,
  secondPage,
  thirdPage,
  fourthPage,
  fifthPage
}

class MainPageProvider extends StatelessWidget {
  const MainPageProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => pageProvider(),
      child: MainPage(),
    );
  }
}

class pageProvider extends ChangeNotifier{
  int _index = 0;
  int get index => _index;

  set index(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Pages selectedPage = Pages.firstPage;

  Map<Pages, Widget> pages = {
    Pages.firstPage : Container( child: Center(child: Text('first',),), color: Colors.blue,),
    Pages.secondPage : Container( child: SecondScroll(),),
    Pages.thirdPage : Container( child: ThirdScroll(),),
    Pages.fourthPage : Container( child: FourthScroll(),),
    Pages.fifthPage : Container( child: Text('fifth'),),
  };

  late pageProvider pageControl;

  @override
  Widget build(BuildContext context) {

    pageControl = Provider.of<pageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(pageControl.index.toString()),
      ),
      body: Container( child: Center(child: Text('first',),), color: Colors.blue,),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'community'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.supervisor_account_rounded), label: 'friend'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'settings'),
        ],
        currentIndex: pageControl.index,
        onTap: (index) => {
          pageControl.index = index
        },
      ),
    );
  }
}
const items = ['item1', 'item2', 'item3'];
var simpleScroll = CustomScrollView(
  slivers: [
    SliverList(delegate: SliverChildBuilderDelegate(
            (context, index){
          return Container(
            alignment: Alignment.center,
            height: 450,
            child: Text(items[index]),
          );
        },
        childCount: items.length
    ))
  ],
);
//Simple Scroll
class FirstScroll extends StatelessWidget {
  const FirstScroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return simpleScroll;
  }
}

//NestedScroll
class SecondScroll extends StatelessWidget {
  const SecondScroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, isInnerBoxScrolled){
          return [
            SliverAppBar(
              title: const Text('Nested Scroll View Appbar'),
              floating: true,
              expandedHeight: 100,
              forceElevated: isInnerBoxScrolled,
            ),
            SliverAppBar(
              title: const Text('Second Nested Scroll View Appbar'),
              titleTextStyle: TextStyle(color: Colors.black),
              backgroundColor: Colors.blue,
              floating: true,
              expandedHeight: 100,
              forceElevated: isInnerBoxScrolled,
            ),
          ];
        },
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 15,
          itemBuilder: (context, index){
            return SizedBox(
              height: 75,
              child: Center(child: Text('item'),),
            );
          }
        )
    );
  }
}

class ThirdScroll extends StatelessWidget {
  const ThirdScroll({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.clear_all),),
            Tab(icon: Icon(Icons.ac_unit)),
            Tab(icon: Icon(Icons.ramen_dining)),
          ],
        ),
        body: TabBarView(
          children: [
            simpleScroll,
            Center(child: Text('second'),),
            Center(child: Text('third'),),
          ],
        ),

      )
    );
  }
}

class FourthScroll extends StatefulWidget {
  const FourthScroll({Key? key}) : super(key: key);

  @override
  State<FourthScroll> createState() => _FourthScrollState();
}

class _FourthScrollState extends State<FourthScroll> with TickerProviderStateMixin{

  late TabController tabControl;

  @override
  void initState(){
    super.initState();
    tabControl = TabController(length: items.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: tabControl,
        tabs: [
          Tab(icon: Icon(Icons.clear_all),),
          Tab(icon: Icon(Icons.ac_unit)),
          Tab(icon: Icon(Icons.ramen_dining)),
        ],
      ),
      body: TabBarView(
        controller: tabControl,
        children: [
          simpleScroll,
          Center(child: Text('second'),),
          Center(child: Text('third'),),
        ],
      ),
    );

  }
}



