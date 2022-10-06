import 'package:flutter_froghome_app/app/data/models/base_model.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';

class RecordEditController extends GetxController with StateMixin<FrogLog> {
  RecordEditController({required this.logKey});
  final logKey;

  final _frogLog = Rxn<FrogLog>();
  get frogLog => _frogLog.value;
  set frogLog(value) => _frogLog.value = value;

  final _plot = Rxn<Plot>();
  get plot => _plot.value;
  set plot(value) => _plot.value = value;

  final _frogs = <Frog>[].obs;
  get frogs => _frogs.value;
  set frogs(value) => _frogs.value = value;

  final _current = Rxn<LogDetail>();
  get current => _current.value;
  set current(value) => _current.value = value;

  @override
  Future<void> onInit() async {
    change(GetStatus.loading());
    frogLog = await DBService.frogLog.get(logKey);
    if (frogLog == null) {
      Get.back();
    }

    await DBService.logs.openBox(frogLog.fileId);

    plot = await DBService.plot.get(frogLog.plot);

    frogs = DBService.base.frogs
        .where((frog) => plot.frogs.contains(frog.id))
        .toList();
    print('${frogs.length}');
    change(GetStatus.success(frogLog));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    await DBService.logs.closeBox();
    super.onClose();
  }

  void Add() {
    if (current == null) {
      current = LogDetail(
        frog: plot.frogs[0],
        sex: 4,
        obs: 0,
        action: 9,
        location: 1,
        subLocation: 1,
        amount: 1,
        locTag: '',
        comment: '',
        remove: false,
      );
    } else {
      final newLog = LogDetail(
        frog: current.frog,
        sex: current.sex,
        obs: current.obs,
        action: 9,
        location: current.location,
        subLocation: current.subLocation,
        amount: 1,
        locTag: current.locTag,
        comment: '',
        remove: false,
      );
      current = newLog;
    }
  }

  void Edit(LogDetail log) {
    current = log;
  }
}
