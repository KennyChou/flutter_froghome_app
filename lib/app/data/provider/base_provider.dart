import 'package:flutter/material.dart';
import 'package:flutter_froghome_app/app/data/models/base_model.dart';
import 'package:get/get.dart';

class BaseV2Provider {
  final Map<int, Family> family = {
    1: Family(name: '蟾蜍科'),
    2: Family(name: '樹蟾科'),
    3: Family(name: '狹口蛙科'),
    4: Family(name: '赤蛙科'),
    5: Family(name: '叉舌蛙科'),
    6: Family(name: '樹蛙科'),
    7: Family(name: '卵齒蟾科'),
  };

  final Map<int, Frog> frogs = {
    1: Frog(family: 1, name: '盤古蟾蜍'),
    2: Frog(family: 1, name: '黑眶蟾蜍'),
    38: Frog(family: 1, name: '海蟾蜍', remove: true),
    3: Frog(family: 2, name: '中國樹蟾'),
    4: Frog(family: 3, name: '巴氏小雨蛙'),
    5: Frog(family: 3, name: '黑蒙西氏小雨蛙'),
    6: Frog(family: 3, name: '小雨蛙'),
    7: Frog(family: 3, name: '史丹吉氏小雨蛙'),
    8: Frog(family: 3, name: '亞洲錦蛙'),
    9: Frog(family: 4, name: '腹斑蛙'),
    10: Frog(family: 4, name: '美洲牛蛙', remove: true),
    11: Frog(family: 4, name: '貢德氏赤蛙'),
    13: Frog(family: 4, name: '拉都希氏赤蛙'),
    15: Frog(family: 4, name: '長腳赤蛙'),
    16: Frog(family: 4, name: '金線蛙'),
    17: Frog(family: 4, name: '豎琴蛙'),
    19: Frog(family: 4, name: '梭德氏赤蛙'),
    20: Frog(family: 4, name: '斯文豪氏赤蛙'),
    21: Frog(family: 4, name: '臺北赤蛙'),
    12: Frog(family: 5, name: '福建大頭蛙'),
    14: Frog(family: 5, name: '澤蛙'),
    18: Frog(family: 5, name: '虎皮蛙'),
    22: Frog(family: 5, name: '海蛙'),
    23: Frog(family: 6, name: '周氏樹蛙'),
    24: Frog(family: 6, name: '褐樹蛙'),
    25: Frog(family: 6, name: '艾氏樹蛙'),
    26: Frog(family: 6, name: '面天樹蛙'),
    27: Frog(family: 6, name: '布氏樹蛙'),
    28: Frog(family: 6, name: '諸羅樹蛙'),
    29: Frog(family: 6, name: '橙腹樹蛙'),
    30: Frog(family: 6, name: '莫氏樹蛙'),
    31: Frog(family: 6, name: '翡翠樹蛙'),
    32: Frog(family: 6, name: '臺北樹蛙'),
    33: Frog(family: 6, name: '斑腿樹蛙', remove: true),
    34: Frog(family: 6, name: '碧眼樹蛙'),
    35: Frog(family: 6, name: '王氏樹蛙'),
    36: Frog(family: 6, name: '太田樹蛙'),
    37: Frog(family: 7, name: '溫室蟾', remove: true),
  };

  final Map<int, Location> location = {
    1: Location(
      name: '流動水域',
      color: Colors.lightBlue,
      defaultSubLocation: 3,
    ),
    8: Location(
      name: '永久性靜止水域',
      color: Colors.blueGrey,
      defaultSubLocation: 28,
    ),
    9: Location(
      name: '暫時性靜止水域',
      color: Colors.brown.shade300,
      defaultSubLocation: 31,
    ),
    10: Location(
      name: '樹木',
      color: Colors.green,
      defaultSubLocation: 35,
    ),
    6: Location(
      name: '草地',
      color: Colors.lightGreen,
      defaultSubLocation: 16,
    ),
    11: Location(
      name: '人造區域',
      color: Colors.orange,
      defaultSubLocation: 39,
    ),
    12: Location(
      name: '其他',
      color: Colors.purple,
      defaultSubLocation: 43,
    ),
  };

  final Map<int, SubLocation> subLocation = {
    1: SubLocation(name: '<5m', location: 1),
    2: SubLocation(name: '>5m', location: 1),
    3: SubLocation(name: '山澗瀑布', location: 1),
    28: SubLocation(name: '水域', location: 8),
    29: SubLocation(name: '岸邊', location: 8),
    30: SubLocation(name: '植物', location: 8),
    31: SubLocation(name: '水域', location: 9),
    32: SubLocation(name: '岸邊', location: 9),
    33: SubLocation(name: '植物', location: 9),
    44: SubLocation(name: '植物積水', location: 9),
    34: SubLocation(name: '喬木', location: 10),
    35: SubLocation(name: '灌木', location: 10),
    36: SubLocation(name: '底層', location: 10),
    37: SubLocation(name: '竹子', location: 10),
    16: SubLocation(name: '短草', location: 6),
    17: SubLocation(name: '高草', location: 6),
    45: SubLocation(name: '邊坡', location: 11),
    38: SubLocation(name: '乾溝', location: 11),
    39: SubLocation(name: '建物', location: 11),
    40: SubLocation(name: '車道', location: 11),
    41: SubLocation(name: '步道', location: 11),
    42: SubLocation(name: '空地', location: 11),
    43: SubLocation(name: '其他', location: 12),
  };

  final Map<int, FrogAction> frogAction = {
    2: FrogAction(name: '聚集'),
    3: FrogAction(name: '嗚叫'),
    4: FrogAction(name: '築巢'),
    5: FrogAction(name: '領域'),
    6: FrogAction(name: '配對'),
    7: FrogAction(name: '打架'),
    8: FrogAction(name: '護幼'),
    9: FrogAction(name: '單獨'),
    10: FrogAction(name: '攝食'),
    11: FrogAction(name: '休息'),
    12: FrogAction(name: '屍體'),
  };

  final Map<int, Sex> sex = {
    1: Sex(name: '卵塊', nickName: '卵', color: Colors.lightBlue),
    2: Sex(name: '蝌蚪', nickName: '蝌', color: Colors.grey),
    3: Sex(name: '幼體', nickName: '幼', color: Colors.brown),
    4: Sex(name: '雄蛙', nickName: '公', color: Colors.green),
    5: Sex(name: '雌蛙', nickName: '母', color: Colors.pink),
    6: Sex(name: '成蛙', nickName: '成', color: Colors.blue),
  };

  List<int> getSubLocation(int location) {
    return subLocation.entries
        .where((element) => element.value.location == location)
        .map((e) => e.key)
        .toList();
  }
}
