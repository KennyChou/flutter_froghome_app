import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:cross_file/cross_file.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';

import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:flutter_froghome_app/app/modules/Widget/text_toast.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';

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

  final commentCtrl = TextEditingController();
  final amountCtrl = TextEditingController();

  final updated_key = (-1).obs;

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
    commentCtrl.dispose();
    amountCtrl.dispose();
    super.onClose();
  }

  void Add() {
    editLog.value = LogDetail(
      frog: editLog.value.frog,
      sex: editLog.value.sex,
      observed: 0,
      action: 9,
      location: editLog.value.location,
      subLocation: editLog.value.subLocation,
      amount: 1,
      locTag: editLog.value.locTag,
      comment: '',
      remove: DBService.base.frogs[editLog.value.frog]!.remove,
    );

    update();
    commentCtrl.text = editLog.value.comment;
    amountCtrl.text = editLog.value.amount.toString();
  }

  void Edit(int index) {
    editLog.value = DBService.logs.values[index];
    commentCtrl.text = editLog.value.comment;
    amountCtrl.text = editLog.value.amount.toString();
  }

  void Save() {
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
          item.amount = item.amount + editLog.value.amount;
          editLog.value = item;
        }
      }
    }

    if (editLog.value.key == null) {
      TextToast.show(
          '新增 ${editLog.value.amount} ${DBService.base.frogs[editLog.value.frog]!.name} ${DBService.base.sex[editLog.value.sex]!.nickName}\n${DBService.base.location[editLog.value.location]!.name}-${DBService.base.subLocation[editLog.value.subLocation]!.name}');

      updated_key.value = -2;
    } else {
      TextToast.show(
          '更新 ${editLog.value.amount} ${DBService.base.frogs[editLog.value.frog]!.name} ${DBService.base.sex[editLog.value.sex]!.nickName}\n${DBService.base.location[editLog.value.location]!.name}-${DBService.base.subLocation[editLog.value.subLocation]!.name}');
      updated_key.value = editLog.value.key;
    }
    print('-----------------${updated_key.value}-----------');

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
    copy_string += '${statFamily.length}科, ${statFrog.keys.length}種, 合計 $sum隻';

    FlutterClipboard.copy(copy_string);
  }

  void writeExcel() async {
    final excelByte = _genExcel()!;
    final fileName =
        '${DBService.syspath}/${plot.name}-${Jiffy(frogLog.value.date).format("yyyy-MM-dd")}.xlsx';
    File(fileName)
      ..createSync(recursive: true)
      ..writeAsBytes(excelByte);

    // Share.shareFiles([fileName]);
    await OpenFilex.open(fileName);
  }

  List<int>? _genExcel() {
    final data = DBService.logs.values.reversed.toList();

    final excel = Excel.createExcel();

    final sheetName = Jiffy(frogLog.value.date).format("yyyy-MM-dd");

    excel.rename(excel.getDefaultSheet()!, sheetName);

    Sheet sheetObject = excel[sheetName];

    sheetObject.appendRow([
      'frog_id',
      'living_type_ids',
      'habitat_id',
      'habitat_p1_id',
      'observing_method_id',
      'amount',
      'behavior_ids',
      'memo',
      '移除',
      '分區',
      '蛙種',
      '生活型態',
      '棲地',
      '微棲地',
      '觀察方法',
      '數量',
      '成體行為',
      '註解',
    ]);
    for (var e in data) {
      final memo = [];
      if (e.locTag != -1) {
        memo.add(plot.sub_location[e.locTag]);
      }
      if (e.remove) {
        memo.add('移除');
      }
      if (e.comment != '') {
        memo.add(e.comment);
      }
      sheetObject.appendRow(
        [
          e.frog,
          e.sex,
          e.location,
          e.subLocation,
          e.observed,
          e.amount,
          e.action,
          memo.join(','),
          e.remove ? 'Y' : '',
          e.locTag != -1 ? plot.sub_location[e.locTag] : '',
          DBService.base.frogs[e.frog]!.name,
          DBService.base.sex[e.sex]!.name,
          DBService.base.location[e.location]!.name,
          DBService.base.subLocation[e.subLocation]!.name,
          e.observed == 0 ? '目擊' : '聽音',
          e.amount,
          DBService.base.frogAction[e.action]!.name,
          e.comment,
        ],
      );
    }

    final plotSheet = excel[plot.name];
    plotSheet.appendRow(['調查樣區', plot.name]);
    plotSheet.appendRow([
      '調查日期',
      Jiffy(frogLog.value.date).format('yyyy-MM-dd'),
    ]);
    plotSheet.appendRow([
      '開始時間',
      Jiffy(frogLog.value.stime).format('HH:mm'),
    ]);
    plotSheet.appendRow([
      '結束時間',
      Jiffy(frogLog.value.etime).format('HH:mm'),
    ]);
    plotSheet.appendRow(['天氣', frogLog.value.weather]);
    plotSheet.appendRow(['溫度', frogLog.value.t1]);
    plotSheet.appendRow(['濕度', frogLog.value.t2]);
    plotSheet.appendRow(['水溫', frogLog.value.t3]);
    plotSheet.appendRow(['參與人員', frogLog.value.member]);
    plotSheet.appendRow(['其它備註', frogLog.value.comment]);

    return excel.save();
  }
}
