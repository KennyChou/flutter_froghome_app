import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/routes/app_pages.dart';

import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        final title = current!.currentPage!.title ?? '兩棲蛙類調查記錄工具';
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text(title),
            centerTitle: true,
          ),
          body: controller.obx(
            (state) => GetRouterOutlet(
              initialRoute: Routes.RECORD_LIST,
            ),
          ),
          drawer: const MenuDrawer(),
        );
      },
    );
  }
}

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 100,
            color: Colors.red,
          ),
          ListTile(
            title: const Text('記錄清單'),
            onTap: () {
              Get.rootDelegate.offAndToNamed(Routes.RECORD_LIST);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('樣區設定'),
            onTap: () {
              Get.rootDelegate.offAndToNamed(Routes.PLOT_LIST);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('Help'),
            onTap: () {
              Get.rootDelegate.offAndToNamed(Routes.HELP);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('深色模式'),
                Obx(
                  () => Switch(
                    value: DBService.settings.darkMode,
                    onChanged: (value) {
                      DBService.settings.updateDarkMode(value);

                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('About'),
            onTap: () {
              Get.rootDelegate.offAndToNamed(Routes.ABOUT);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
