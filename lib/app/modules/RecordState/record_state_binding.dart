import 'package:get/get.dart';

import 'record_state_controller.dart';

class RecordStateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordStateController>(
      () => RecordStateController(
        logKey: int.tryParse(Get.parameters['logKey']!),
      ),
    );
  }
}
