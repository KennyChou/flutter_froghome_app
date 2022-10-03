import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'record_list_controller.dart';

class RecordListView extends GetView<RecordListController> {
  const RecordListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'RecordListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
