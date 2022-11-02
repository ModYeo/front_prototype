import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSliverRefreshControl extends StatelessWidget {
  const CustomSliverRefreshControl({Key? key, required this.onRefresh}) : super(key: key);

  final Future Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return CupertinoSliverRefreshControl(
      onRefresh: onRefresh,
      builder: (context, mode, d, e, f) => Center(child: CircularProgressIndicator()),
    );
  }
}