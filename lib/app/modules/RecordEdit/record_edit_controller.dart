import 'package:clipboard/clipboard.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';

import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class RecordEditController extends GetxController with StateMixin<FrogLog> {
  RecordEditController({this.logKey});
  final int? logKey;

  final frogLog = FrogLog().obs;
  final _plot = Plot().obs;
  Plot get plot => _plot.value;
  set plot(value) => _plot.value = value;
  final editLog = LogDetail().obs;

  final continueInput = true.obs;

  final List<int> statFamily = [];
  final Map<int, Map> statFrog = {};

  @override
  Future<void> onInit() async {
    change(GetStatus.loading());
    frogLog.value = await DBService.frogLog.get(logKey!);
    if (frogLog.value.key == null) {
      Get.back();
    }

    await DBService.logs.openBox(frogLog.value.fileId, sort: 1);

    plot = await DBService.plot.get(frogLog.value.plot);

    change(GetStatus.success(frogLog.value));
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
    if (editLog.value.key == null) {
      editLog.value = LogDetail(
        frog: plot.frogs.first,
        sex: 4,
        observed: 0,
        action: 9,
        location: 10,
        subLocation: 36,
        amount: 1,
        locTag: plot.sub_location.isNotEmpty ? 0 : -1,
        comment: '',
        remove: false,
      );
    } else {
      final newLog = LogDetail(
        frog: editLog.value.frog,
        sex: editLog.value.sex,
        observed: editLog.value.observed,
        action: 9,
        location: editLog.value.location,
        subLocation: editLog.value.subLocation,
        amount: 1,
        locTag: editLog.value.locTag,
        comment: '',
        remove: DBService.base.frogs[editLog.value.frog]!.remove,
      );
      editLog.value = newLog;
    }
    update();
  }

  void Edit(int index) {
    editLog.value = DBService.logs.values[index];
  }

  void Save() {
    print('Save ${editLog.value.frog}');
    if (plot.autoCount) {
      if (editLog.value.key == null) {
        final item = DBService.logs.values.firstWhereOrNull((e) =>
            e.frog == editLog.value.frog &&
            e.sex == editLog.value.sex &&
            e.location == editLog.value.location &&
            e.subLocation == editLog.value.subLocation &&
            e.action == editLog.value.action &&
            e.observed == editLog.value.observed &&
            e.remove == editLog.value.remove &&
            editLog.value.comment == '' &&
            e.comment == '' &&
            e.locTag == editLog.value.locTag &&
            editLog.value.action != 2);

        if (item != null) {
          print('------${item.key} ${item.location} ${item.subLocation}');
          print(
              '------ ${editLog.value.location} ${editLog.value.subLocation}');
          item.amount = item.amount + editLog.value.amount;
          editLog.value = item;
        }
      }
    }

    DBService.logs.put(editLog.value);
  }

  void stateData() {
    statFamily.clear();
    statFrog.clear();
    for (var e in DBService.logs.values) {
      if (!statFamily.contains(DBService.base.frogs[e.frog]!.family)) {
        statFamily.add(DBService.base.frogs[e.frog]!.family);
      }

      if (!statFrog.containsKey(e.frog)) {
        statFrog.addEntries([
          MapEntry(e.frog, {
            'qty': e.amount,
            'remove': e.remove ? e.amount : 0,
          })
        ]);
      } else {
        print(" -------- ${statFrog[e.frog]!['qty']}");
        statFrog[e.frog]!['qty'] = statFrog[e.frog]!['qty'] + e.amount;
        if (e.remove) {
          statFrog[e.frog]!['remove'] = statFrog[e.frog]!['remove'] + e.amount;
        }
      }
      print('${statFrog[e.frog]!["qty"]} ${statFrog[e.frog]!["remove"]}');
    }
    statFamily.sort((a, b) => a.compareTo(b));
    print(statFamily);
  }

  void copy_clipboard() {
    String copy_string = '';

    copy_string =
        "${Jiffy(frogLog.value.date).format('yyyy-MM-dd')}  ${plot.name}\n";

    for (var f in statFamily) {
      copy_string += "${DBService.base.family[f]!.name}:";
      copy_string += DBService.base.frogs.entries
          .where((frog) =>
              statFrog.containsKey(frog.key) && frog.value.family == f)
          .map((e) =>
              "${e.value.name} ${e.value.remove ? "${statFrog[e.key]!['remove']}/" : ''}${statFrog[e.key]!['qty']}")
          .toList()
          .join(', ');
      copy_string += '\n';
    }
    var sum = statFrog.entries
        .map((e) => e.value['qty'])
        .toList()
        .reduce((a, b) => a + b);
    copy_string +=
        '${statFamily.length}科, ${statFrog.keys.length}種, 合計 ${sum}隻';

    FlutterClipboard.copy(copy_string);
  }

  void doExcel() {
    final data = DBService.logs.values;
    data.sort((a, b) => (a.key).compareTo(b.key));
  }
}
