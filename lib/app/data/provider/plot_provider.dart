import 'package:get/get.dart';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlotProvider {
  final values = <Plot>[].obs;

  Future<void> init() async {
    Box<Plot> box = await Hive.openBox<Plot>('plots');
    values.value = box.values.toList();
    await box.close();
  }

  Future<Plot?> get(int key) async {
    Box<Plot> box = await Hive.openBox<Plot>('plots');
    final plot = box.get(key);
    box.close();
    return plot;
  }

  Future<void> put(Plot plot) async {
    Box<Plot> box = await Hive.openBox<Plot>('plots');
    if (plot.key == null) {
      await box.add(plot);
    } else {
      final old = box.get(plot.key);
      if (old != null) {
        old.name = plot.name;
        old.frogs = plot.frogs;
        old.sub_location = plot.sub_location;
        old.tags = plot.tags;
        old.save();
      }
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
