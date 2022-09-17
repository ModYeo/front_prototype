import 'package:flutter/material.dart';

popupTemplate(context)
{
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),//round edge
    title : const Text('Dialog Title'),
    content: const Text('Content'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('cancel'))
    ],
  );
}
popupTemplate_scrollable(context)
{
  var testBox = Container(
    height: 150,
    width: double.infinity,
  );

  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),//round edge
    title : const Text('Dialog Title'),
    content: SingleChildScrollView(
      child: Column(
        children: [
          testBox,
          testBox,
          testBox
        ],
      ),
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('cancel'))
    ],
  );
}

void showPopup(context)
{
  showDialog(
    //barrierDismissible: false, //is it able to click outside of the box to close?
    context: context,
    builder: (context) => popupTemplate(context)
  );
}

Future<void> showPopup_autoClose(context) async => showDialog(
  context: context,
  builder: (context){
    Future.delayed(const Duration(milliseconds: 2000), (){
      Navigator.pop(context);
    });
    return popupTemplate(context);
  }
);
