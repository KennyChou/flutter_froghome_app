import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';

class PlotListController extends GetxController {
  //TODO: Implement PlotListController

  @override
  void onInit() {
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
      tags: [],
      autoCount: true,
    );
    await DBService.plot.put(plot);
  }
}
