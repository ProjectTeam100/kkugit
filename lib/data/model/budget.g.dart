// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BudgetAdapter extends TypeAdapter<Budget> {
  @override
  final int typeId = 3;

  @override
  Budget read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Budget(
      id: fields[0] as int,
      dateTime: fields[1] as DateTime,
      unit: fields[2] as String,
      budget: fields[3] as int,
      groupBudget: fields[4] as GroupBudget,
    );
  }

  @override
  void write(BinaryWriter writer, Budget obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.unit)
      ..writeByte(3)
      ..write(obj.budget)
      ..writeByte(4)
      ..write(obj.groupBudget);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GroupBudgetAdapter extends TypeAdapter<GroupBudget> {
  @override
  final int typeId = 4;

  @override
  GroupBudget read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupBudget(
      id: fields[0] as int,
      groupId: fields[1] as int,
      budget: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GroupBudget obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.groupId)
      ..writeByte(2)
      ..write(obj.budget);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupBudgetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
