import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'plot_edit_controller.dart';

class PlotEditView extends GetView<PlotEditController> {
  const PlotEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlotEditView'),
        centerTitle: true,
      ),
      body: controller.obx(
        (state) => Column(
          children: [
            const Card(
              child: ListTile(
                title: TextField(
                  decoration: InputDecoration(
                    labelText: '樣區名稱',
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(controller.plot.name),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
