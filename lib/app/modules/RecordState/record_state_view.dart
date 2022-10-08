import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'record_state_controller.dart';

class RecordStateView extends GetView<RecordStateController> {
  const RecordStateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('統計資料'),
        centerTitle: true,
      ),
      body: Center(child: Text('fdsdsd')),
    );
  }
}
