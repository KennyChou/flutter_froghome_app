import 'package:flutter_froghome_app/app/data/models/base_model.dart';
import 'package:get/get.dart';

class BaseProvider {
  final family = <Family>[].obs;
  final frogs = <Frog>[].obs;

  void init() {
    family.value = [
      Family(name: '蟾蜍科', id: 1),
      Family(name: '樹蟾科', id: 2),
      Family(name: '狹口蛙科', id: 3),
      Family(name: '赤蛙科', id: 4),
      Family(name: '叉舌蛙科', id: 5),
      Family(name: '樹蛙科', id: 6),
      Family(name: '卵齒蟾科', id: 7),
    ];

    frogs.value = [
      Frog(family: 1, name: '盤古蟾蜍', id: 1),
      Frog(family: 1, name: '黑眶蟾蜍', id: 2),
      Frog(family: 1, name: '海蟾蜍', id: 38),
      Frog(family: 2, name: '中國樹蟾', id: 3),
      Frog(family: 3, name: '巴氏小雨蛙', id: 4),
      Frog(family: 3, name: '黑蒙西氏小雨蛙', id: 5),
      Frog(family: 3, name: '小雨蛙', id: 6),
      Frog(family: 3, name: '史丹吉氏小雨蛙', id: 7),
      Frog(family: 3, name: '亞洲錦蛙', id: 8),
      Frog(family: 4, name: '腹斑蛙', id: 9),
      Frog(family: 4, name: '美洲牛蛙', id: 10),
      Frog(family: 4, name: '貢德氏赤蛙', id: 11),
      Frog(family: 4, name: '拉都希氏赤蛙', id: 13),
      Frog(family: 4, name: '長腳赤蛙', id: 15),
      Frog(family: 4, name: '金線蛙', id: 16),
      Frog(family: 4, name: '豎琴蛙', id: 17),
      Frog(family: 4, name: '梭德氏赤蛙', id: 19),
      Frog(family: 4, name: '斯文豪氏赤蛙', id: 20),
      Frog(family: 4, name: '臺北赤蛙', id: 21),
      Frog(family: 5, name: '福建大頭蛙', id: 12),
      Frog(family: 5, name: '澤蛙', id: 14),
      Frog(family: 5, name: '虎皮蛙', id: 18),
      Frog(family: 5, name: '海蛙', id: 22),
      Frog(family: 6, name: '周氏樹蛙', id: 23),
      Frog(family: 6, name: '褐樹蛙', id: 24),
      Frog(family: 6, name: '艾氏樹蛙', id: 25),
      Frog(family: 6, name: '面天樹蛙', id: 26),
      Frog(family: 6, name: '布氏樹蛙', id: 27),
      Frog(family: 6, name: '諸羅樹蛙', id: 28),
      Frog(family: 6, name: '橙腹樹蛙', id: 29),
      Frog(family: 6, name: '莫氏樹蛙', id: 30),
      Frog(family: 6, name: '翡翠樹蛙', id: 31),
      Frog(family: 6, name: '臺北樹蛙', id: 32),
      Frog(family: 6, name: '斑腿樹蛙', id: 33),
      Frog(family: 6, name: '碧眼樹蛙', id: 34),
      Frog(family: 6, name: '王氏樹蛙', id: 35),
      Frog(family: 6, name: '太田樹蛙', id: 36),
      Frog(family: 7, name: '溫室蟾', id: 37),
    ];
  }
}
