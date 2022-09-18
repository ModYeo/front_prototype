import 'package:flutter/material.dart';

class BoardView extends StatelessWidget {
  const BoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context){
              return [
                PopupMenuItem(child: Text('first'))
              ];
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('title'),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                direction: Axis.vertical,
                                children: [
                                  Placeholder(
                                    fallbackWidth: 50,
                                    fallbackHeight: 20,
                                  ),
                                  Text('Writer'),
                                  Text('Nickname')
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Wrap(
                                direction: Axis.vertical,
                                children: [
                                  Text('views'),
                                  Text('date')
                                ],
                              ),
                            )
                          ],
                        )
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text('content'),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.lightGreen,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Wrap(
                              children: [
                                Icon(Icons.thumb_up),
                                Text('10')
                              ],
                            ),
                            Wrap(
                              children: [
                                Icon(Icons.message),
                                Text('10')
                              ],
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(onPressed: (){}, icon: Icon(Icons.upload_rounded),),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => null,
              childCount: 0
            ),
          )
        ],
      ),
    );
  }
}
