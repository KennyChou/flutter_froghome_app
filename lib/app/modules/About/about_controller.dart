import 'package:get/get.dart';
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
}
