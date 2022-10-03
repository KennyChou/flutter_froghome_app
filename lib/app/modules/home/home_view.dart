import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/routes/app_pages.dart';

import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('兩棲蛙類調查記錄工具'),
        centerTitle: true,
      ),
      body: controller.obx(
        (state) => GetRouterOutlet(
          initialRoute: Routes.RECORD_LIST,
          delegate: Get.nestedKey(null),
          anchorRoute: '/',
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 100,
              color: Colors.red,
            ),
            ListTile(
              title: const Text('記錄清單'),
              onTap: () {
                Get.toNamed(Routes.RECORD_LIST);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('樣區設定'),
              onTap: () {
                Get.toNamed(Routes.PLOT_LIST);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Help'),
              onTap: () {
                Get.toNamed(Routes.HELP);
                Navigator.of(context).pop();
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('About'),
              onTap: () {
                Get.toNamed(Routes.HELP);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
