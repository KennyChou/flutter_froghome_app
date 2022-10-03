import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'record_edit_controller.dart';

class RecordEditView extends GetView<RecordEditController> {
  const RecordEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecordEditView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'RecordEditView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
