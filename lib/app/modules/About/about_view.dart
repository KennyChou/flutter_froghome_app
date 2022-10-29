import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (info) => Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: const AssetImage('assets/images/logo.png'),
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                const Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text('本APP無償提供維護,\n請配合後台外掛,\n可以輕鬆記錄並上傳。'),
                ),
                ElevatedButton(
                  onPressed: () async => await launchUrl(
                      Uri.parse(
                          'https://kennychou.github.io/2021/12/14/%E5%85%A9%E6%A3%B2%E5%BF%97%E5%B7%A5%E8%9B%99%E9%A1%9E%E8%AA%BF%E8%A8%98%E9%8C%84%E5%99%A8/'),
                      mode: LaunchMode.externalApplication),
                  child: Wrap(
                    children: const [
                      Text('後台說明'),
                      Icon(Icons.link),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () async => showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('確定還原預設值'),
                            content: const Text('請小心使用\n將會刪除全部資料！！'),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text('取消'),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all(Colors.red),
                                    ),
                                    child: const Text('確定'),
                                    onPressed: () async {
                                      await controller.clearDB();
                                      Get.back();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    child: Wrap(
                      children: const [Text('還原預設值'), Icon(Icons.delete)],
                    ))
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Center(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('APP版本'),
                    const SizedBox(width: 20),
                    Text('V${info!.version}+${info.buildNumber}'),
                  ],
                ),
              ),
              Text('Created By Kenny Chou',
                  style: Theme.of(context).textTheme.caption),
            ],
          )),
        ),
      ),
    );
  }
}
