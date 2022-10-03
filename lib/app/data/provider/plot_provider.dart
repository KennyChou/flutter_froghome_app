import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';

class PlotProvider {
  final values = <Plot>[].obs;

  Future<void> init() async {
    Box<Plot> box = await Hive.openBox<Plot>('plots');
    values.value = box.values.toList();
    await box.close();
  }

  Future<Plot> get(int key) async {
    return values.value.firstWhere((element) => element.key == key);
  }

  Future<void> put(Plot plot) async {
    Box<Plot> box = await Hive.openBox<Plot>('plots');
    if (plot.key == null) {
      await box.add(plot);
    } else {
      plot.save();
    }
    values.value = box.values.toList();
    await box.close();
  }

  Future<void> delete(Plot plot) async {
    Box<Plot> box = await Hive.openBox<Plot>('plots');
    box.delete(plot.key);
    values.value = box.values.toList();
    await box.close();
  }

  Future<void> clear() async {
    Box<Plot> box = await Hive.openBox<Plot>('plots');
    box.clear();
    values.value = box.values.toList();
    await box.close();
  }
}
