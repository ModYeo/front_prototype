import 'package:flutter/material.dart';
import 'package:unnamed_project/home/crew/crew_community.dart';
import 'package:unnamed_project/home/crew/crew_home.dart';
import 'package:unnamed_project/home/home_board.dart';
import 'package:unnamed_project/home/mypage/mypage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late List<GlobalKey<NavigatorState>> _navigators;

  var _currentTab = 2;

  @override
  void initState() {
    _navigators = List.generate(5, (index) => GlobalKey<NavigatorState>());
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void onTabChange(index){
    setState((){_currentTab = index;});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {return false;},
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              getOffStageView(CrewHome(navigator: _navigators[0],), 0),
              getOffStageView(Text('second'), 1),
              getOffStageView(HomeBoardView(), 2),
              getOffStageView(Text('fourth'),3),
              getOffStageView(MyPageView(),4),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentTab,
            onTap: onTabChange,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.group), label: 'group',),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
              BottomNavigationBarItem(icon: Icon(Icons.people), label: 'people'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'mypage'),
            ],
          )
        ),
      ),
    );
  }

  Widget getOffStageView(Widget child, int index){
    return Offstage(
      offstage: _currentTab != index,
      child: child,
    );
  }
}


