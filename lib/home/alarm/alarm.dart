import 'package:flutter/material.dart';

class AlarmView extends StatelessWidget {
  const AlarmView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Alarm'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                spacing: 10,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text('Unchecked Alarms ___'),
                    ),
                  ),
                  TextButton(onPressed: (){}, child: Text('Check all alarm'))
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) =>
                AlarmListTile(context),
                childCount: 3
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget AlarmListTile(context) => Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Wrap(
      direction: Axis.vertical,
      children: [
        Text('alarm title'),
        Text('content')
      ],
    ),
  );
}


