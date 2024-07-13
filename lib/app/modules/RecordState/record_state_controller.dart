import 'package:flutter_froghome_app/app/data/models/base_model.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';

import 'package:get/get.dart';

class RecordStateController extends GetxController with StateMixin<bool> {
  RecordStateController({required this.logKey});
  final logKey;

  final _frogLog = Rxn<FrogLog>();
  get frogLog => _frogLog.value;
  set frogLog(value) => _frogLog.value = value;

  final _plot = Rxn<Plot>();
  Plot? get plot => _plot.value;
  set plot(value) => _plot.value = value;

  final List<int> statFamily = [];
  final Map<int, Map> frog = {};

  @override
  void onInit() async {
    frogLog = await DBService.frogLog.get(logKey);
    if (frogLog == null) {
      Get.back();
    }

    await DBService.logs.openBox(frogLog.fileId);

    plot = await DBService.plot.get(frogLog.plot);

    stateData();

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

  void stateData() {
    for (var e in DBService.logs.values) {
      if (!statFamily.contains(DBService.base.frogs[e.frog]!.family)) {
        statFamily.add(DBService.base.frogs[e.frog]!.family);
      }
      if (!frog.containsKey(e)) {
        frog.addEntries([
          MapEntry(e.frog, {
            'watch': e.observed == 0 ? e.amount : 0,
            'heard': e.observed == 1 ? e.amount : 0,
            'remove': e.remove ? e.amount : 0,
          })
        ]);
      } else {
        if (e.obs == 0) {
          frog[e.frog]!['watch'] = frog[e.frog]!['watch'] + e.amount;
        } else {
          frog[e.frog]!['heard'] = frog[e.frog]!['heard'] + e.amount;
        }

        if (e.remove) {
          frog[e.frog]!['qty'] = frog[e.frog]!['remove'] + e.amount;
        }
      }
    }
    print(statFamily);
    print(frog);
  }
}
