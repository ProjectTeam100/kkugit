// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spending.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpendingAdapter extends TypeAdapter<Spending> {
  @override
  final int typeId = 0;

  @override
  Spending read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Spending(
      id: fields[0] as int,
      dateTime: fields[1] as DateTime,
      client: fields[2] as String,
      payment: fields[3] as String,
      category: fields[4] as int,
      group: fields[5] as int,
      price: fields[6] as int,
      memo: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Spending obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.client)
      ..writeByte(3)
      ..write(obj.payment)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.group)
      ..writeByte(6)
      ..write(obj.price)
      ..writeByte(7)
      ..write(obj.memo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpendingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
