import 'package:get/get.dart';

import 'link_page_controller.dart';

class LinkPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LinkPageController>(
      () => LinkPageController(),
    );
  }
}
