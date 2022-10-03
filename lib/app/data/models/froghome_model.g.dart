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
      name: fields[0] as String,
      frogs: (fields[1] as List).cast<int>(),
      sub_location: (fields[2] as List).cast<String>(),
      tags: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Plot obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.frogs)
      ..writeByte(2)
      ..write(obj.sub_location)
      ..writeByte(3)
      ..write(obj.tags);
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
