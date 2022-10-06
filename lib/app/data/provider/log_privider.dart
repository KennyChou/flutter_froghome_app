import 'dart:async';

import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class LogProvider {
  Box<LogDetail>? _box;
  final _values = <LogDetail>[].obs;
  List<LogDetail> get values => _values.value;
  set values(List<LogDetail> value) => _values.value = value;

  int _orderby = 0;

  StreamSubscription<BoxEvent>? _stream;

  Future<void> openBox(String dbName, {int sort = 0}) async {
    _box = await Hive.openBox<LogDetail>(dbName);
    values = _box!.values.toList();
    _orderby = sort;
    _sort();

    _stream = _box!.watch().listen((event) {
      print('---------------$event------------');
      values = _box!.values.toList();
      _sort();
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

  void _sort() {
    print('sort $_orderby');
    if (_orderby == 0) {
      values.sort((a, b) => (a.key).compareTo(b.key));
    } else if (_orderby == 1) {
      values.sort((a, b) => b.key.compareTo(a.key));
    }
  }
}
