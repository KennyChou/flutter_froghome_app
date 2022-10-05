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

  Plot(
      {required this.name,
      required this.frogs,
      required this.sub_location,
      required this.tags});

  @override
  String toString() => '{key: ${key}, name: ${name}, frogs: ${frogs.length}}';
}

@HiveType(typeId: 2)
class FrogLog extends HiveObject {
  @HiveField(0)
  Plot plot;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  DateTime stime;
  @HiveField(3)
  DateTime etime;
  @HiveField(4)
  String weather;
  @HiveField(5)
  double? t1;
  @HiveField(6)
  double? t2;
  @HiveField(7)
  double? t3;
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
    required this.weather,
    required this.member,
    required this.comment,
    required this.fileId,
  });
  @override
  String toString() => 'FrogList{${fileId}, ${key}}';
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
