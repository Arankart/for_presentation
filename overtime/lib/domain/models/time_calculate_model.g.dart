// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_calculate_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeDataModelAdapter extends TypeAdapter<TimeDataModel> {
  @override
  final int typeId = 2;

  @override
  TimeDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeDataModel(
      fields[4] as DateTime?,
      fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, TimeDataModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(4)
      ..write(obj.dataStart)
      ..writeByte(5)
      ..write(obj.dataEnd);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
