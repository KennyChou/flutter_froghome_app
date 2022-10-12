import 'package:flutter_froghome_app/app/data/services/dbservices.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<bool> {
  //TODO: Implement HomeController

  @override
  void onInit() async {
    change(false, status: RxStatus.loading());
    Get.put(await DBService().init());

    change(true, status: RxStatus.success());
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
