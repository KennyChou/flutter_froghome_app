import 'package:get/get.dart';

import 'record_state_controller.dart';

class RecordStateBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<RecordStateController>(
        () => RecordStateController(
            logKey: int.tryParse(Get.parameters['logKey']!)),
      )
    ];
  }
}
