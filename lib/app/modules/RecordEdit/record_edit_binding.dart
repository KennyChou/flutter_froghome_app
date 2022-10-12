import 'package:get/get.dart';
import 'record_edit_controller.dart';

class RecordEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecordEditController>(
      () => RecordEditController(
        logKey: int.tryParse(
          Get.parameters['logKey']!,
        ),
      ),
    );
  }
}
