import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unnamed_project/custom_components/chat_bar.dart';
import 'package:unnamed_project/main.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => JustViewModel(), child: JustMain(),);
  }
}

class JustMain extends StatelessWidget {
  const JustMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangeNotifierProvider(create: (context) => JustViewModel(), child: JustView(),))); }, child: Text('d'),)),
    );
  }
}

class JustPage extends StatelessWidget {
  const JustPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => JustViewModel(), child: JustView(),);
  }
}

class JustView extends StatelessWidget{

  late JustViewModel viewModel;
  late UserData user;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<JustViewModel>(context);
    user = Provider.of<UserData>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(),
          SliverToBoxAdapter(
            child: Text(viewModel.count.toString())
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index){
              return Container(child: Text('something'),);
            },
            childCount: viewModel.list.length
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){ viewModel.addCount(); },),
    );
  }
}

class JustViewModel with ChangeNotifier{
  int count = 0;

  late List<int> list;

  JustViewModel(){ list = getManagingCrews(); print('created');}

  void addCount(){
    count++;
    notifyListeners();
  }

  List<int> getManagingCrews(){
    return List.generate(count, (index) => index);
  }
}
