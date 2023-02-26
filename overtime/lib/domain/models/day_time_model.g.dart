// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_time_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayTimeModelAdapter extends TypeAdapter<DayTimeModel> {
  @override
  final int typeId = 1;

  @override
  DayTimeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayTimeModel(
      fields[0] as int?,
      (fields[1] as List?)?.cast<TimeDataModel>(),
      fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DayTimeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dataList)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayTimeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
