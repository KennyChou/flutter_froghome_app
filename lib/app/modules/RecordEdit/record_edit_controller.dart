import 'package:clipboard/clipboard.dart';
import 'package:flutter/services.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class RecordEditController extends GetxController with StateMixin<FrogLog> {
  RecordEditController({required this.logKey});
  final logKey;

  final _frogLog = Rxn<FrogLog>();
  get frogLog => _frogLog.value;
  set frogLog(value) => _frogLog.value = value;

  final _plot = Rxn<Plot>();
  Plot? get plot => _plot.value;
  set plot(value) => _plot.value = value;

  final _current = Rxn<LogDetail>();
  LogDetail? get current => _current.value;
  set current(value) => _current.value = value;

  final _continueInput = true.obs;
  bool get continueInput => _continueInput.value;
  set continueInput(bool value) => _continueInput.value = value;

  final List<int> statFamily = [];
  final Map<int, Map> statFrog = {};

  @override
  Future<void> onInit() async {
    change(GetStatus.loading());
    frogLog = await DBService.frogLog.get(logKey);
    if (frogLog == null) {
      Get.back();
    }

    await DBService.logs.openBox(frogLog.fileId, sort: 1);

    plot = await DBService.plot.get(frogLog.plot);

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
        frog: plot!.frogs.first,
        sex: 4,
        obs: 0,
        action: 9,
        location: 10,
        subLocation: 36,
        amount: 1,
        locTag: plot!.sub_location.isNotEmpty ? 0 : null,
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
    if (plot!.autoCount) {
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
            e.comment == '' &&
            e.locTag == current!.locTag &&
            current!.action != 2);

        if (item != null) {
          print('------${item.key} ${item.location} ${item.subLocation}');
          print('------ ${current!.location} ${current!.subLocation}');
          item.amount = item.amount + current!.amount;
          current = item;
        }
      }
    }

    DBService.logs.put(current!);
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
        "${Jiffy(frogLog.date).format('yyyy-MM-dd')}  ${plot!.name}\n";

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
}
