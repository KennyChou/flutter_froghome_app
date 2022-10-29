import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutController extends GetxController with StateMixin<PackageInfo> {
  @override
  late PackageInfo packageInfo;
  void onInit() async {
    change(null, status: RxStatus.loading());
    packageInfo = await PackageInfo.fromPlatform();
    change(packageInfo, status: RxStatus.success());
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

  Future<void> clearDB() async {
    for (var plot in DBService.plot.values) {
      for (var log in DBService.frogLog.values) {
        if (log.plot == plot.key) {
          await Hive.deleteBoxFromDisk(log.fileId);
          // await DBService.logs.deleteBox(log.fileId);
          // await DBService.frogLog.delete(log);
        }
      }
    }
    await Hive.deleteBoxFromDisk('frogLog');

    await Hive.deleteBoxFromDisk('plots');
    await DBService.plot.init();
    await DBService.frogLog.init();
  }
}
