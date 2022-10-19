import 'package:get/get.dart';

class Link {
  Link(
    this.name,
    this.url,
  );
  String name;
  String url;
}

class LinkPageController extends GetxController {
  @override
  final links = [
    Link('台灣兩棲類動物保育協會', 'https://www.froghome.org/'),
    Link('兩棲類資源調查資訊網',
        'https://tad.froghome.org/upload/rlogin.php?OK_URL=upload_main.php&FAIL_URL=rlogin.php'),
    Link('台灣兩棲保育志工', 'https://www.facebook.com/groups/180892885268726'),
    Link('臺灣蛇類快速辨別圖鑑', 'https://www.taiwan-snakes.tw/'),
  ].obs;

  void onInit() {
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
