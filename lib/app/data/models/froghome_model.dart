import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'froghome_model.g.dart';

@HiveType(typeId: 1)
class Plot extends HiveObject {
  @HiveField(0, defaultValue: '新增樣區')
  String name;
  @HiveField(1, defaultValue: [])
  List<int> frogs;
  @HiveField(2, defaultValue: [])
  List<String> sub_location;
  @HiveField(3, defaultValue: [])
  List<String> tags;
  @HiveField(4, defaultValue: true)
  bool autoCount;

  Plot({
    this.name = '新增樣區',
    this.frogs = const [],
    this.sub_location = const [],
    this.tags = const [],
    this.autoCount = true,
  });

  @override
  String toString() => '{key: ${key}, name: ${name}, frogs: ${frogs.length}}';
}

@HiveType(typeId: 2)
class FrogLog extends HiveObject {
  @HiveField(0)
  int plot;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  DateTime stime;
  @HiveField(3)
  DateTime etime;
  @HiveField(4)
  String weather;
  @HiveField(5)
  String t1;
  @HiveField(6)
  String t2;
  @HiveField(7)
  String t3;
  @HiveField(8)
  String member;
  @HiveField(9)
  String comment;
  @HiveField(10)
  String fileId;

  FrogLog({
    this.plot = 1,
    DateTime? date,
    DateTime? stime,
    DateTime? etime,
    this.weather = '晴',
    this.t1 = '',
    this.t2 = '',
    this.t3 = '',
    this.member = '',
    this.comment = '',
    String? fileId,
  })  : this.date = date ?? DateTime.now(),
        this.stime = stime ?? DateTime.now(),
        this.etime = etime ?? DateTime.now().add(const Duration(minutes: 60)),
        this.fileId = fileId ?? UniqueKey().toString();
  @override
  String toString() => 'FrogLog{${fileId}, ${key} ${plot}}';
}

@HiveType(typeId: 3)
class LogDetail extends HiveObject {
  @HiveField(0, defaultValue: 1)
  int frog;
  @HiveField(1, defaultValue: 4)
  int sex;
  @HiveField(2, defaultValue: 0)
  int obs;
  @HiveField(3, defaultValue: 9)
  int action;
  @HiveField(4, defaultValue: 10)
  int location;
  @HiveField(5, defaultValue: 36)
  int subLocation;
  @HiveField(6, defaultValue: 1)
  int amount;
  @HiveField(7, defaultValue: null)
  int? locTag;
  @HiveField(8, defaultValue: '')
  String comment;
  @HiveField(9, defaultValue: false)
  bool remove;

  LogDetail(
      {this.frog = 1,
      this.sex = 4,
      this.obs = 0,
      this.action = 9,
      this.location = 10,
      this.subLocation = 36,
      this.amount = 1,
      this.locTag = null,
      this.comment = '',
      this.remove = false});
  @override
  String toString() => 'LogDetail{${frog}, ${key}}';
}
