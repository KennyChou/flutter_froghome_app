import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';

import 'package:get/get.dart';

import 'help_controller.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('深色模式'),
            Obx(
              () => Switch(
                value: DBService.settings.darkMode,
                onChanged: (value) {
                  DBService.settings.updateDarkMode(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
