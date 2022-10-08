import 'package:flutter/widgets.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';

class PlotEditController extends GetxController with StateMixin<Plot> {
  PlotEditController({required this.plotKey});
  final plotKey;

  final _plot = Rxn<Plot>();

  get plot => _plot.value;
  set plot(value) => _plot.value = value;

  final nameCtrl = TextEditingController();

  final nameFocus = FocusNode();
  final frogFocus = FocusNode();
  final subFoccus = FocusNode();
  final tagFoucs = FocusNode();

  final autoCount = true.obs;

  @override
  void onInit() async {
    // change(GetStatus.loading());
    plot = await DBService.plot.get(plotKey);
    nameCtrl.text = plot.name;
    autoCount.value = plot.autoCount;
    print(plot.frogs);
    change(GetStatus.success(plot));
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

  Future<void> Save() async {
    plot.name = nameCtrl.text;
    plot.autoCount = autoCount.value;
    await DBService.plot.put(plot);
    Get.back();
  }

  void removeSub(int index) {
    change(GetStatus.loading());
    _plot.value!.sub_location.removeAt(index);
    _plot.refresh();
    change(GetStatus.success(plot));
  }

  void addSub(String val) {
    change(GetStatus.loading());
    _plot.value!.sub_location.add(val);
    _plot.refresh();
    change(GetStatus.success(plot));
  }

  void removeTags(int index) {
    change(GetStatus.loading());
    _plot.value!.tags.removeAt(index);
    _plot.refresh();
    change(GetStatus.success(plot));
  }

  void addTags(String val) {
    change(GetStatus.loading());
    _plot.value!.tags.add(val);
    _plot.refresh();
    change(GetStatus.success(plot));
  }
}
