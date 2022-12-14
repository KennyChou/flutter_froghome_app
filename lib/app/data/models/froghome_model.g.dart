// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'froghome_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlotAdapter extends TypeAdapter<Plot> {
  @override
  final int typeId = 1;

  @override
  Plot read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Plot(
      name: fields[0] == null ? '新增樣區' : fields[0] as String,
      frogs: fields[1] == null ? [] : (fields[1] as List).cast<int>(),
      sub_location: fields[2] == null ? [] : (fields[2] as List).cast<String>(),
      tags: fields[3] == null ? [] : (fields[3] as List).cast<String>(),
      autoCount: fields[4] == null ? true : fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Plot obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.frogs)
      ..writeByte(2)
      ..write(obj.sub_location)
      ..writeByte(3)
      ..write(obj.tags)
      ..writeByte(4)
      ..write(obj.autoCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlotAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FrogLogAdapter extends TypeAdapter<FrogLog> {
  @override
  final int typeId = 2;

  @override
  FrogLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FrogLog(
      plot: fields[0] as int,
      date: fields[1] as DateTime?,
      stime: fields[2] as DateTime?,
      etime: fields[3] as DateTime?,
      weather: fields[4] as String,
      t1: fields[5] as String,
      t2: fields[6] as String,
      t3: fields[7] as String,
      member: fields[8] as String,
      comment: fields[9] as String,
      fileId: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FrogLog obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.plot)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.stime)
      ..writeByte(3)
      ..write(obj.etime)
      ..writeByte(4)
      ..write(obj.weather)
      ..writeByte(5)
      ..write(obj.t1)
      ..writeByte(6)
      ..write(obj.t2)
      ..writeByte(7)
      ..write(obj.t3)
      ..writeByte(8)
      ..write(obj.member)
      ..writeByte(9)
      ..write(obj.comment)
      ..writeByte(10)
      ..write(obj.fileId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FrogLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LogDetailAdapter extends TypeAdapter<LogDetail> {
  @override
  final int typeId = 3;

  @override
  LogDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogDetail(
      frog: fields[0] == null ? 1 : fields[0] as int,
      sex: fields[1] == null ? 4 : fields[1] as int,
      observed: fields[2] == null ? 0 : fields[2] as int,
      action: fields[3] == null ? 9 : fields[3] as int,
      location: fields[4] == null ? 10 : fields[4] as int,
      subLocation: fields[5] == null ? 36 : fields[5] as int,
      amount: fields[6] == null ? 1 : fields[6] as int,
      locTag: fields[7] == null ? -1 : fields[7] as int,
      comment: fields[8] == null ? '' : fields[8] as String,
      remove: fields[9] == null ? false : fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LogDetail obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.frog)
      ..writeByte(1)
      ..write(obj.sex)
      ..writeByte(2)
      ..write(obj.observed)
      ..writeByte(3)
      ..write(obj.action)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.subLocation)
      ..writeByte(6)
      ..write(obj.amount)
      ..writeByte(7)
      ..write(obj.locTag)
      ..writeByte(8)
      ..write(obj.comment)
      ..writeByte(9)
      ..write(obj.remove);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
