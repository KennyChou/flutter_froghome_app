import 'package:get/get.dart';

import 'plot_list_controller.dart';

class PlotListBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<PlotListController>(
        () => PlotListController(),
      )
    ];
  }
}
