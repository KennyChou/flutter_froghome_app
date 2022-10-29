import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class RecordListController extends GetxController
    with StateMixin<List<FrogLog>> {
  final _editLog = FrogLog().obs;
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
    // if (DBService.plot.values.isEmpty) {
    //   Get.rootDelegate.offAndToNamed(Routes.PLOT_LIST);
    // }
    change(null, status: RxStatus.loading());

    if (DBService.frogLog.values.isNotEmpty) {
      change(DBService.frogLog.values, status: RxStatus.success());
    } else {
      change(null, status: RxStatus.empty());
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    dateCtrl.dispose();
    stimeCtrl.dispose();
    etimeCtrl.dispose();
    t1Ctrl.dispose();
    t2Ctrl.dispose();
    t3Ctrl.dispose();
    memberCtrl.dispose();
    commentCtrl.dispose();
    super.onClose();
  }

  void Add() {
    editLog = FrogLog(
        plot: DBService.plot.values.first.key,
        date: Jiffy().dateTime,
        stime: Jiffy().dateTime,
        etime: Jiffy().add(minutes: 60).dateTime,
        fileId: UniqueKey().toString());

    print(editLog.plot);
    initCtrl();
  }

  void Edit(index) {
    editLog = DBService.frogLog.values[index];
    initCtrl();
  }

  void initCtrl() {
    dateCtrl.text = Jiffy(editLog.date).format('MM-dd');
    stimeCtrl.text = Jiffy(editLog.stime).format('HH:mm');
    etimeCtrl.text = Jiffy(editLog.etime).format('HH:mm');

    t1Ctrl.text = editLog.t1;
    t2Ctrl.text = editLog.t2;
    t3Ctrl.text = editLog.t3;
    memberCtrl.text = editLog.member;
    commentCtrl.text = editLog.comment;
  }

  Future<void> save() async {
    // print(editLog.plot);

    editLog.t1 = t1Ctrl.text;
    editLog.t2 = t2Ctrl.text;
    editLog.t3 = t3Ctrl.text;
    editLog.member = memberCtrl.text;
    editLog.comment = commentCtrl.text;
    await DBService.frogLog.put(editLog);
    DBService.frogLog.values.refresh();
    update();

    if (DBService.frogLog.values.isNotEmpty) {
      change(DBService.frogLog.values, status: RxStatus.success());
    }
  }

  Future<void> delete(int index) async {
    await DBService.frogLog.delete(DBService.frogLog.values[index]);
    DBService.frogLog.values.refresh();
    update();
    if (DBService.frogLog.values.isEmpty) {
      change(null, status: RxStatus.empty());
      Get.back();
    }
  }
}
