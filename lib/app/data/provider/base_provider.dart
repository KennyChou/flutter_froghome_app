import 'package:flutter_froghome_app/app/data/models/base_model.dart';
import 'package:get/get.dart';

class BaseProvider {
  final family = <Family>[].obs;
  final frogs = <Frog>[].obs;
  final location = <Location>[].obs;
  final action = <FrogAction>[].obs;
  final sex = <Sex>[].obs;

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
      Frog(family: 1, name: '海蟾蜍', id: 38, remove: true),
      Frog(family: 2, name: '中國樹蟾', id: 3),
      Frog(family: 3, name: '巴氏小雨蛙', id: 4),
      Frog(family: 3, name: '黑蒙西氏小雨蛙', id: 5),
      Frog(family: 3, name: '小雨蛙', id: 6),
      Frog(family: 3, name: '史丹吉氏小雨蛙', id: 7),
      Frog(family: 3, name: '亞洲錦蛙', id: 8),
      Frog(family: 4, name: '腹斑蛙', id: 9),
      Frog(family: 4, name: '美洲牛蛙', id: 10, remove: true),
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
      Frog(family: 6, name: '斑腿樹蛙', id: 33, remove: true),
      Frog(family: 6, name: '碧眼樹蛙', id: 34),
      Frog(family: 6, name: '王氏樹蛙', id: 35),
      Frog(family: 6, name: '太田樹蛙', id: 36),
      Frog(family: 7, name: '溫室蟾', id: 37, remove: true),
    ];

    location.value = [
      Location(
        name: '流動水域',
        id: 1,
        defaultValue: 1,
        children: [
          SubLocation(id: 1, name: '<5m', value: 1),
          SubLocation(id: 2, name: '>5m', value: 2),
          SubLocation(id: 3, name: '山澗瀑布', value: 3),
        ],
      ),
      Location(
        name: '永久性靜止水域',
        id: 8,
        defaultValue: 4,
        children: [
          SubLocation(id: 4, name: '水域', value: 28),
          SubLocation(id: 5, name: '岸邊', value: 29),
          SubLocation(id: 6, name: '植物', value: 30),
        ],
      ),
      Location(
        name: '暫時性靜止水域',
        id: 9,
        defaultValue: 7,
        children: [
          SubLocation(id: 7, name: '水域', value: 31),
          SubLocation(id: 8, name: '岸邊', value: 32),
          SubLocation(id: 9, name: '植物', value: 33),
          SubLocation(id: 10, name: '植物積水', value: 44),
        ],
      ),
      Location(
        name: '樹木',
        id: 10,
        defaultValue: 12,
        children: [
          SubLocation(id: 11, name: '喬木', value: 34),
          SubLocation(id: 12, name: '灌木', value: 35),
          SubLocation(id: 13, name: '底層', value: 36),
          SubLocation(id: 14, name: '竹子', value: 37),
        ],
      ),
      Location(
        name: '草地',
        id: 6,
        defaultValue: 15,
        children: [
          SubLocation(id: 15, name: '短草', value: 16),
          SubLocation(id: 16, name: '高草', value: 17),
        ],
      ),
      Location(
        name: '人造區域',
        id: 11,
        defaultValue: 19,
        children: [
          SubLocation(id: 17, name: '邊坡', value: 45),
          SubLocation(id: 18, name: '乾溝', value: 38),
          SubLocation(id: 19, name: '建物', value: 39),
          SubLocation(id: 20, name: '車道', value: 40),
          SubLocation(id: 21, name: '步道', value: 41),
          SubLocation(id: 22, name: '空地', value: 42),
        ],
      ),
      Location(
        name: '其他',
        id: 12,
        defaultValue: 23,
        children: [
          SubLocation(id: 23, name: '其他', value: 43),
        ],
      ),
    ];

    action.value = [
      FrogAction(id: 2, name: '聚集'),
      FrogAction(id: 3, name: '嗚叫'),
      FrogAction(id: 4, name: '築巢'),
      FrogAction(id: 5, name: '領域'),
      FrogAction(id: 6, name: '配對'),
      FrogAction(id: 7, name: '打架'),
      FrogAction(id: 8, name: '護幼'),
      FrogAction(id: 9, name: '單獨'),
      FrogAction(id: 10, name: '攝食'),
      FrogAction(id: 11, name: '休息'),
      FrogAction(id: 12, name: '屍體'),
    ];

    sex.value = [
      Sex(name: '卵塊', id: 1),
      Sex(name: '蝌蚪', id: 2),
      Sex(name: '幼體', id: 3),
      Sex(name: '雄蛙', id: 4),
      Sex(name: '雌蛙', id: 5),
      Sex(name: '成蛙', id: 6),
    ];
  }
}
