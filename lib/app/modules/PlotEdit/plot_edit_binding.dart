import 'package:get/get.dart';

import 'plot_edit_controller.dart';

class PlotEditBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<PlotEditController>(
        () => PlotEditController(plotKey: int.parse(Get.parameters['key']!)),
      )
    ];
  }
}
