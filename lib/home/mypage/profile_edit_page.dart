import 'package:flutter/material.dart';
import 'package:unnamed_project/theme/style.dart';

class ProfileEditPageView extends StatelessWidget {
  const ProfileEditPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Edit'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(left: 10, right: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  color: Theme.of(context).colorScheme.primary,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            Placeholder(
                              fallbackHeight: 50,
                              fallbackWidth: 50,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt_rounded),),
                            )
                          ],
                        ),
                      ),
                      Text('Username'),
                      Spacer(),
                      IconButton(onPressed: (){}, icon: Icon(Icons.edit))
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Text('Hello'),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: defaultBox.copyWith(
                          color: Theme.of(context).colorScheme.primary
                        ),
                        child: Text('content')
                      )
                    ],
                  ),
                )
              ])
            ),
          )
        ],
      ),
    );
  }
}
