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
