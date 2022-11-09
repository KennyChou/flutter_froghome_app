import 'package:flutter/widgets.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';

class PlotEditController extends GetxController with StateMixin<bool> {
  PlotEditController({required this.plotKey});
  int plotKey;

  final plot = Plot().obs;
  final tabIndex = 0.obs;

  final nameCtrl = TextEditingController();
  final subCtrl = TextEditingController();
  final memoCtrl = TextEditingController();

  final nameFocus = FocusNode();
  final frogFocus = FocusNode();
  final autoFocus = FocusNode();
  final subFocus = FocusNode();
  final tagFoucs = FocusNode();

  final autoCount = true.obs;

  @override
  void onInit() async {
    change(false, status: RxStatus.loading());
    plot.value = await DBService.plot.get(plotKey);
    nameCtrl.text = plot.value.name;
    subCtrl.text = '';
    memoCtrl.text = '';

    autoCount.value = plot.value.autoCount;
    autoFocus.requestFocus();

    // plot.refresh();
    // nameFocus.requestFocus();
    change(true, status: RxStatus.success());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() async {
    nameFocus.dispose();
    frogFocus.dispose();
    subFocus.dispose();
    tagFoucs.dispose();
    autoFocus.dispose();

    nameCtrl.dispose();
    subCtrl.dispose();
    memoCtrl.dispose();

    await autoSave();
    await DBService.plot.closeBox();

    super.onClose();
  }

  Future<void> autoSave() async {
    plot.value.name = nameCtrl.text;
    plot.value.autoCount = autoCount.value;
    plot.value.frogs.sort((a, b) => a.compareTo(b));
    await plot.value.save();

    // await DBService.plot.put(plot.value);

    // Get.back();
  }

  Future<void> subAdd() async {
    if (!plot.value.sub_location.contains(subCtrl.text) &&
        subCtrl.text.isNotEmpty) {
      plot.value.sub_location.add(subCtrl.text);
      // autoSave();
      plot.refresh();
    }
    subCtrl.text = '';
    subFocus.requestFocus();
  }

  Future<void> tagAdd() async {
    if (!plot.value.tags.contains(memoCtrl.text) && memoCtrl.text.isNotEmpty) {
      plot.value.tags.add(memoCtrl.text);
      // autoSave();
      plot.refresh();
    }
    memoCtrl.text = '';
    tagFoucs.requestFocus();
  }
}
