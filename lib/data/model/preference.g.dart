// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preference.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreferenceAdapter extends TypeAdapter<Preference> {
  @override
  final int typeId = 5;

  @override
  Preference read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Preference(
      id: fields[0] as int,
      name: fields[1] as String,
      data: fields[2] as Object,
    );
  }

  @override
  void write(BinaryWriter writer, Preference obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreferenceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
