import 'package:flutter/widgets.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';

class PlotEditController extends GetxController with StateMixin<bool> {
  PlotEditController({required this.plotKey});
  final plotKey;

  final _plot = Rxn<Plot>();

  final tags = <String>[].obs;

  get plot => _plot.value;
  set plot(value) => _plot.value = value;

  final nameCtrl = TextEditingController();

  @override
  void onInit() async {
    change(GetStatus.loading());
    plot = await DBService.plot.get(plotKey);
    print(plot);
    change(GetStatus.success(true));
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
}
