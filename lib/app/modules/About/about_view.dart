import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Theme.of(context).colorScheme.primary,
        child: Center(
            child: Text('Created By Kenny Chou',
                style: Theme.of(context).textTheme.caption)),
      ),
    );
  }
}
