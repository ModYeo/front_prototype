import 'package:flutter/material.dart';

class ChatBarTestPage extends StatelessWidget {
  const ChatBarTestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text('test'),
          Text('test2')
        ],
      ),
      bottomSheet: BottomAppBar(
        child: TestChatBar(),
      ),
    );
  }
}

class TestChatBar extends StatefulWidget {
  const TestChatBar({Key? key}) : super(key: key);

  @override
  State<TestChatBar> createState() => _TestChatBarState();
}

class _TestChatBarState extends State<TestChatBar> {
  
  bool _isExpanded = false;

  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
  }
  
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: (){
                      setState((){_isExpanded = !_isExpanded; });
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    icon: Icon(Icons.add)
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      controller: _controller,
                      onTap: (){

                      },
                    ),
                  ),
                  ElevatedButton(onPressed: (){}, child: Text('send'))
                ],
              ),
            ),
            (_isExpanded == false) ? Container(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.book))
                  ],
                ),
              ),
            ) : const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}


class ChatBar extends StatefulWidget {
  const ChatBar({Key? key, this.backgroundDecoration, this.frontIcon, this.controller, this.inputDecoration}) : super(key: key);

  final Decoration? backgroundDecoration;
  final Icon? frontIcon;

  final TextEditingController? controller;
  final InputDecoration? inputDecoration;


  @override
  State<ChatBar> createState() => _ChatBarState();
}

class _ChatBarState extends State<ChatBar> {

  late TextEditingController _textController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController = (widget.controller != null) ? widget.controller! : TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.backgroundDecoration,
      child: Row(
        children: [
          widget.frontIcon ?? const SizedBox(),
          TextField(
            controller: _textController,
          )
        ],
      ),
    );
  }
}
