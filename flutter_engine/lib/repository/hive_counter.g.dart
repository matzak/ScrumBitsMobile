// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_counter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveCounterAdapter extends TypeAdapter<HiveCounter> {
  @override
  final int typeId = 0;

  @override
  HiveCounter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveCounter(
      value: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveCounter obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveCounterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
