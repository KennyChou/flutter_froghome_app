import 'package:get/get.dart';

import 'record_list_controller.dart';

class RecordListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordListController>(
      () => RecordListController(),
    );
  }
}
