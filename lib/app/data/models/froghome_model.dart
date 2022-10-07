import 'package:hive/hive.dart';

part 'froghome_model.g.dart';

@HiveType(typeId: 1)
class Plot extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> frogs;
  @HiveField(2)
  List<String> sub_location;
  @HiveField(3)
  List<String> tags;
  @HiveField(4, defaultValue: true)
  bool autoCount;

  Plot({
    required this.name,
    required this.frogs,
    required this.sub_location,
    required this.tags,
    required this.autoCount,
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
    required this.plot,
    required this.date,
    required this.stime,
    required this.etime,
    this.weather = '晴',
    this.t1 = '',
    this.t2 = '',
    this.t3 = '',
    this.member = '',
    this.comment = '',
    required this.fileId,
  });
  @override
  String toString() => 'FrogLog{${fileId}, ${key} ${plot}}';
}

@HiveType(typeId: 3)
class LogDetail extends HiveObject {
  @HiveField(0)
  int frog;
  @HiveField(1)
  int sex;
  @HiveField(2)
  int obs;
  @HiveField(3)
  int action;
  @HiveField(4)
  int location;
  @HiveField(5)
  int subLocation;
  @HiveField(6)
  int amount;
  @HiveField(7)
  String locTag;
  @HiveField(8)
  String comment;
  @HiveField(9)
  bool remove;

  LogDetail(
      {required this.frog,
      required this.sex,
      required this.obs,
      required this.action,
      required this.location,
      required this.subLocation,
      required this.amount,
      required this.locTag,
      required this.comment,
      required this.remove});
  @override
  String toString() => 'LogDetail{${frog}, ${key}}';
}
