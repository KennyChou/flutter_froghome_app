import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';

class FrogLogProvider {
  final values = <FrogLog>[].obs;

  Future<void> init() async {
    Box<FrogLog> box = await Hive.openBox<FrogLog>('frogLog');
    values.value = box.values.toList();
    await box.close();
  }

  Future<void> put(FrogLog log) async {
    Box<FrogLog> box = await Hive.openBox<FrogLog>('frogLog');
    if (log.key == null) {
      await box.add(log);
    } else {
      final old = box.get(log.key);
      if (old != null) {
        await old.save();
      }
    }
    values.value = box.values.toList();
    await box.close();
  }

  Future<void> delete(FrogLog log) async {
    Box<FrogLog> box = await Hive.openBox<FrogLog>('frogLog');
    final detail = await Hive.openBox(log.fileId);
    await detail.deleteFromDisk();
    await box.delete(log.key);
    values.value = box.values.toList();
    await box.close();
  }

  Future<void> clear() async {
    Box<FrogLog> box = await Hive.openBox<FrogLog>('frogLog');
    box.clear();
    values.value = box.values.toList();
    await box.close();
  }
}
