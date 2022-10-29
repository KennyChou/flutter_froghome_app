import 'package:get/get.dart';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlotProvider {
  final values = <Plot>[].obs;
  Box<LogDetail>? _box;

  Future<void> init() async {
    Box<Plot> box = await Hive.openBox<Plot>('plots');
    values.value = box.values.toList().reversed.toList();
    print('plot init ....');
    print(values.value);
    await box.close();
  }

  Future<Plot> get(int key) async {
    Box<Plot> _box = await Hive.openBox<Plot>('plots');
    final plot = _box.get(key, defaultValue: Plot());
    return plot!;
  }

  Future<void> closeBox() async {
    if (_box != null) await _box!.close();
    await init();
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
        old.autoCount = plot.autoCount;
        old.save();
      }
    }
    values.value = box.values.toList().reversed.toList();
    await box.close();
  }

  Future<void> delete(Plot plot) async {
    Box<Plot> box = await Hive.openBox<Plot>('plots');
    box.delete(plot.key);
    values.value = box.values.toList().reversed.toList();
    await box.close();
  }

  Future<void> clear() async {
    // Box<Plot> box = await Hive.openBox<Plot>('plots');
    // box.clear();
    // // values.value = box.values.toList().reversed.toList();
    // values.value = [];
    // await box.close();
    print('plot clear...');
    final box = await Hive.openBox('plots');
    box.deleteFromDisk();
    print('plot clear... 1 ');
    // await box.close();
    print('plot clear... 2');
    await init();
    print('plot clear...3');
  }

  String getName(int key) {
    return values.firstWhere((element) => element.key == key).name;
  }
}
