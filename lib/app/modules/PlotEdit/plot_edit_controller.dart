import 'package:flutter/widgets.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';

class PlotEditController extends GetxController with StateMixin<bool> {
  PlotEditController({required this.plotKey});
  int plotKey;

  final plot = Plot().obs;

  final nameCtrl = TextEditingController();

  final nameFocus = FocusNode();
  final frogFocus = FocusNode();
  final subFoccus = FocusNode();
  final tagFoucs = FocusNode();

  final autoCount = true.obs;

  @override
  void onInit() async {
    change(GetStatus.loading());
    plot.value = await DBService.plot.get(plotKey);
    nameCtrl.text = plot.value.name;
    autoCount.value = plot.value.autoCount;

    plot.refresh();

    change(GetStatus.success(true));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameFocus.dispose();
    frogFocus.dispose();
    subFoccus.dispose();
    tagFoucs.dispose();
    nameCtrl.dispose();
    super.onClose();
  }

  Future<void> autoSave() async {
    plot.value.name = nameCtrl.text;
    plot.value.autoCount = autoCount.value;

    await DBService.plot.put(plot.value);

    Get.back();
  }
}
