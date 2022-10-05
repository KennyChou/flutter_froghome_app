import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class RecordListController extends GetxController
    with StateMixin<List<FrogLog>> {
  final _editLog = Rxn<FrogLog>();
  get editLog => _editLog.value;
  set editLog(value) => _editLog.value = value;

  final dateCtrl = TextEditingController();
  final stimeCtrl = TextEditingController();
  final etimeCtrl = TextEditingController();
  final t1Ctrl = TextEditingController();
  final t2Ctrl = TextEditingController();
  final t3Ctrl = TextEditingController();
  final memberCtrl = TextEditingController();
  final commentCtrl = TextEditingController();
  @override
  void onInit() {
    change(GetStatus.loading());
    if (DBService.frogLog.values.isNotEmpty) {
      change(GetStatus.success(DBService.frogLog.values));
    } else {
      change(GetStatus.error('empty'));
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void Add() {
    editLog = FrogLog(
        plot: DBService.plot.values.first,
        date: Jiffy().dateTime,
        stime: Jiffy().dateTime,
        etime: Jiffy().add(minutes: 60).dateTime,
        weather: '晴',
        member: '',
        comment: '',
        fileId: UniqueKey().toString());

    print(editLog.plot);
    initCtrl();
  }

  void Edit(index) {
    editLog = DBService.frogLog.values[index];
    initCtrl();
  }

  void initCtrl() {
    dateCtrl.text = Jiffy(editLog.date).format('yyyy-MM-dd');
    stimeCtrl.text = Jiffy(editLog.stime).format('HH:mm');
    etimeCtrl.text = Jiffy(editLog.etime).format('HH:mm');

    t1Ctrl.text = editLog.t1 == null ? '' : editLog.t1.toString();
    t2Ctrl.text = editLog.t2 == null ? '' : editLog.t2.toString();
    t3Ctrl.text = editLog.t3 == null ? '' : editLog.t3.toString();
    memberCtrl.text = editLog.member;
    commentCtrl.text = editLog.comment;
  }

  void Save() {
    print(editLog.plot);
  }
}
