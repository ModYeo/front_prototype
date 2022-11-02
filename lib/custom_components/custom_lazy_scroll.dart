import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomLazyScrollView extends StatefulWidget {
  CustomLazyScrollView({Key? key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.scrollBehavior,
    this.shrinkWrap = false,
    this.center,
    this.anchor = 0.0,
    this.cacheExtent,
    this.slivers = const <Widget>[],
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = Clip.hardEdge,
    required this.onReachEnd}) : super(key: key);

  Axis scrollDirection;
  bool reverse = false;
  ScrollController? controller;
  bool? primary;
  ScrollPhysics? physics;
  ScrollBehavior? scrollBehavior;
  bool shrinkWrap = false;
  Key? center;
  double anchor = 0.0;
  double? cacheExtent;
  List<Widget> slivers ;
  int? semanticChildCount;
  DragStartBehavior dragStartBehavior = DragStartBehavior.start;
  ScrollViewKeyboardDismissBehavior keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual;
  String? restorationId;
  Clip clipBehavior = Clip.hardEdge;

  Future Function() onReachEnd;

  @override
  State<CustomLazyScrollView> createState() => _CustomLazyScrollViewState();
}

class _CustomLazyScrollViewState extends State<CustomLazyScrollView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller ??= ScrollController();
    widget.controller?.addListener(() async {
      if(widget.controller?.position.pixels == widget.controller?.position.maxScrollExtent){
        await widget.onReachEnd();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: widget.scrollDirection,
      reverse : widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      scrollBehavior: widget.scrollBehavior,
      shrinkWrap : widget.shrinkWrap = false,
      center : widget.center,
      anchor : widget.anchor = 0.0,
      cacheExtent: widget.cacheExtent,
      slivers: widget.slivers,
      semanticChildCount: widget.semanticChildCount,
      dragStartBehavior: widget.dragStartBehavior = DragStartBehavior.start,
      keyboardDismissBehavior: widget.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
      restorationId: widget.restorationId,
      clipBehavior: widget.clipBehavior = Clip.hardEdge,
    );
  }
}


