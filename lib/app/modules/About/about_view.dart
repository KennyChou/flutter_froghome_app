import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        color: Theme.of(context).colorScheme.primary,
        child: Center(
            child: Text('Create By Kenny Chou',
                style: Theme.of(context).textTheme.caption)),
      ),
      // bottomSheet: Container(
      //   padding: EdgeInsets.all(5),
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(30),
      //       topRight: Radius.circular(30),
      //     ),
      //     color: Theme.of(context).colorScheme.background,
      //     boxShadow: [
      //       BoxShadow(
      //           // color: Theme.of(context).colorScheme.surfaceVariant,
      //           offset: Offset(-0.5, -0.5), //陰影y軸偏移量
      //           blurRadius: 0.5, //陰影模糊程度
      //           spreadRadius: 0.5 //陰影擴散程度
      //           ),
      //     ],
      //   ),
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Expanded(child: Text('CopyRight Kenny Chou dddddd')),
      //   ),
      // ),
    );
  }
}
