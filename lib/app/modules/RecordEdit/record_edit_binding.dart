import 'package:get/get.dart';
import 'record_edit_controller.dart';

class RecordEditBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<RecordEditController>(
        () => RecordEditController(
            logKey: int.tryParse(Get.parameters['logKey']!)),
      ),
    ];
  }
}
