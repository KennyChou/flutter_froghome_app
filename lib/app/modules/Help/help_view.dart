import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';

import 'package:get/get.dart';

import 'help_controller.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        ListTile(
          title: Text(
            '深色模式',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          trailing: Obx(
            () => Switch(
              value: DBService.settings.darkMode,
              onChanged: (value) {
                DBService.settings.updateDarkMode(value);
              },
            ),
          ),
        ),
        ListTile(
          title: Text(
            '新增訊息',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          trailing: Obx(
            () => Switch(
              value: DBService.settings.messageMode,
              onChanged: (value) {
                DBService.settings.updateMessageMode(value);
              },
            ),
          ),
        ),
      ],
    )
        // body: Container(
        //   padding: const EdgeInsets.all(20),
        //   child: Column(
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text(
        //             '深色模式',
        //             style: Theme.of(context).textTheme.titleLarge,
        //           ),
        // Obx(
        //   () => Switch(
        //     value: DBService.settings.darkMode,
        //     onChanged: (value) {
        //       DBService.settings.updateDarkMode(value);
        //     },
        //   ),
        // ),
        //         ],
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Text(
        //             '新增訊息',
        //             style: Theme.of(context).textTheme.titleLarge,
        //           ),
        //           Obx(
        //             () => Switch(
        //               value: DBService.settings.messageMode,
        //               onChanged: (value) {
        //                 DBService.settings.updateMessageMode(value);
        //               },
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
