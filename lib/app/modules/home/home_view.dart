import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/routes/app_pages.dart';

import 'package:get/get.dart';

import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RouterOutlet.builder(
      delegate: Get.nestedKey(null),
      builder: (context) {
        final title =
            context.delegate.currentConfiguration?.route?.title ?? '兩棲蛙類調查記錄工具';
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text(title),
            centerTitle: true,
          ),
          body: controller.obx(
            (state) => GetRouterOutlet(
              initialRoute: Routes.RECORD_LIST,
              delegate: Get.nestedKey(null),
              anchorRoute: '/',
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
          ListTile(
            title: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('深色模式'),
                  Switch(
                    value: DBService.settings.darkMode,
                    onChanged: (value) =>
                        DBService.settings.updateDarkMode(value),
                  ),
                ],
              ),
            ),
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
    );
  }
}
