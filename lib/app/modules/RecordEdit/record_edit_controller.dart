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

  final _current = Rxn<LogDetail>();
  LogDetail? get current => _current.value;
  set current(value) => _current.value = value;

  @override
  Future<void> onInit() async {
    change(GetStatus.loading());
    frogLog = await DBService.frogLog.get(logKey);
    if (frogLog == null) {
      Get.back();
    }

    await DBService.logs.openBox(frogLog.fileId, sort: 1);

    plot = await DBService.plot.get(frogLog.plot);

    // frogs = DBService.base.frogs
    //     .where((frog) => plot.frogs.contains(frog.id))
    //     .toList();

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
        frog: plot.frogs.first,
        sex: 4,
        obs: 0,
        action: 9,
        location: 10,
        subLocation: 36,
        amount: 1,
        locTag: plot.sub_location.length > 0 ? plot.sub_location.first : '',
        comment: '',
        remove: false,
      );
    } else {
      final newLog = LogDetail(
        frog: current!.frog,
        sex: current!.sex,
        obs: current!.obs,
        action: 9,
        location: current!.location,
        subLocation: current!.subLocation,
        amount: 1,
        locTag: current!.locTag,
        comment: '',
        remove: DBService.base.frogs[current!.frog]!.remove,
      );
      current = newLog;
    }
  }

  void Edit(int index) {
    current = DBService.logs.values[index];
  }

  void Save() {
    print(current!.frog);
    if (plot.autoCount) {
      if (current!.key == null) {
        final item = DBService.logs.values.firstWhereOrNull((e) =>
            e.frog == current!.frog &&
            e.sex == current!.sex &&
            e.location == current!.location &&
            e.subLocation == current!.subLocation &&
            e.action == current!.action &&
            e.obs == current!.obs &&
            e.remove == current!.remove &&
            current!.comment == '' &&
            e.locTag == current!.locTag &&
            current!.action != 2);

        if (item != null) {
          item.amount = item.amount + current!.amount;
          current = item;
        }
      }
    }

    DBService.logs.put(current!);

    Add();
  }
}
