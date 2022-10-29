import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';

class PlotListController extends GetxController {
  final plots = <Plot>[].obs;

  @override
  void onInit() {
    refresh();
    plots.value = DBService.plot.values;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> add() async {
    final plot = Plot(
      name: '新樣區',
      frogs: DBService.base.frogs.keys.toList(),
      sub_location: [],
      tags: ['雨傘節', '龜殼花', '赤尾青竹絲', '紅斑蛇', '泰雅鈍頭蛇'],
      autoCount: true,
    );
    await DBService.plot.put(plot);
    updateData();
  }

  void updateData() {
    plots.value = DBService.plot.values;
  }

  Future<void> delete(Plot plot) async {
    for (var log in DBService.frogLog.values) {
      if (log.plot == plot.key) {
        await DBService.logs.deleteBox(log.fileId);
        DBService.frogLog.delete(log);
      }
    }

    DBService.plot.delete(plot);
    updateData();
    Get.back();
  }
}
