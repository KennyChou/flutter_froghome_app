import 'package:get/get.dart';

import 'plot_edit_controller.dart';

class PlotEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlotEditController>(
      () => PlotEditController(plotKey: int.parse(Get.parameters['key']!)),
    );
  }
}
