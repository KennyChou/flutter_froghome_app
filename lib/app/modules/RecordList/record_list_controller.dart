import 'package:flutter_froghome_app/app/data/models/froghome_model.dart';
import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';

class RecordListController extends GetxController
    with StateMixin<List<FrogLog>> {
  //TODO: Implement RecordListController

  @override
  void onInit() {
    change(GetStatus.loading());
    if (DBService.frogLog.values.isNotEmpty) {
      change(GetStatus.success(DBService.frogLog.values));
    } else {
      change(GetStatus.error('fdd'));
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
}
