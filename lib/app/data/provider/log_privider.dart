import 'dart:async';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class LogProvider {
  Box<LogDetail>? _box;
  final _values = <LogDetail>[].obs;
  get values => _values.value;
  set values(value) => _values.value = value;

  StreamSubscription<BoxEvent>? _stream;

  Future<void> openBox(String dbName) async {
    _box = await Hive.openBox<LogDetail>(dbName);
    values = _box!.values.toList();

    _stream = _box!.watch().listen((event) {
      print('---------------$event------------');
      values = _box!.values.toList();
    });
  }

  Future<void> put(LogDetail log) async {
    // print('key=====${log.key}');
    if (log.key == null) {
      _box!.add(log);
    } else {
      log.save();
    }
    // values = _box!.values.toList();
    // _sort();
    // print('----put exit');
  }

  Future<void> delete(LogDetail log) async {
    _box!.delete(log.key);
    // values = _box!.values.toList();
    // _sort();
  }

  Future<void> clear() async {
    await _box!.clear();
    // values = _box!.values.toList();
  }

  Future<void> closeBox() async {
    if (_stream != null) _stream?.cancel();
    if (_box != null) await _box!.close();
  }
}
