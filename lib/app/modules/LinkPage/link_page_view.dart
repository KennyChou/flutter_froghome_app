import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'link_page_controller.dart';

class LinkPageView extends GetView<LinkPageController> {
  const LinkPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ListView.builder(
          itemCount: controller.links.length,
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(Icons.link),
            title: Text(controller.links[index].name),
            onTap: () async => await launchUrl(
                Uri.parse(controller.links[index].url),
                mode: LaunchMode.externalApplication),
          ),
        ),
      ),
    );
  }
}
