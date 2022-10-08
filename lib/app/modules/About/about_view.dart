import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Obx(() => Text('${controller.count}')),
          ElevatedButton(
            onPressed: () => controller.increment(),
            child: Text('click'),
          ),
          ElevatedButton(
            onPressed: () => showEditLog(context),
            child: Text('click'),
          ),
        ]),
      ),
    );
  }
}

Future<void> showEditLog(BuildContext context) async {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    builder: (context) {
      return NewWidget();
    },
  );
}

class NewWidget extends StatelessWidget {
  NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();
    return Scaffold(
      body: Column(
        children: [
          Obx(() => Text('${controller.count}')),
          ElevatedButton(
            onPressed: () => controller.increment(),
            child: Text('fsdsdf'),
          ),
        ],
      ),
    );
  }
}
