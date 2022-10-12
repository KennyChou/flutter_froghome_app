import 'package:get/get.dart';

import 'plot_list_controller.dart';

class PlotListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlotListController>(
      () => PlotListController(),
    );
  }
}
