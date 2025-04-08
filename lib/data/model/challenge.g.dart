// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChallengeAdapter extends TypeAdapter<Challenge> {
  @override
  final int typeId = 6;

  @override
  Challenge read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Challenge(
      id: fields[0] as int,
      dateTime: fields[1] as DateTime,
      type: fields[2] as ChallengeType,
      budget: fields[3] as int,
      status: fields[4] as ChallengeStatus,
    );
  }

  @override
  void write(BinaryWriter writer, Challenge obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.budget)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChallengeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChallengeTypeAdapter extends TypeAdapter<ChallengeType> {
  @override
  final int typeId = 7;

  @override
  ChallengeType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ChallengeType.noSpend;
      case 1:
        return ChallengeType.threeDays;
      case 2:
        return ChallengeType.weekly;
      case 3:
        return ChallengeType.twoWeeks;
      default:
        return ChallengeType.noSpend;
    }
  }

  @override
  void write(BinaryWriter writer, ChallengeType obj) {
    switch (obj) {
      case ChallengeType.noSpend:
        writer.writeByte(0);
        break;
      case ChallengeType.threeDays:
        writer.writeByte(1);
        break;
      case ChallengeType.weekly:
        writer.writeByte(2);
        break;
      case ChallengeType.twoWeeks:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChallengeTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChallengeStatusAdapter extends TypeAdapter<ChallengeStatus> {
  @override
  final int typeId = 8;

  @override
  ChallengeStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ChallengeStatus.ongoing;
      case 1:
        return ChallengeStatus.success;
      case 2:
        return ChallengeStatus.fail;
      default:
        return ChallengeStatus.ongoing;
    }
  }

  @override
  void write(BinaryWriter writer, ChallengeStatus obj) {
    switch (obj) {
      case ChallengeStatus.ongoing:
        writer.writeByte(0);
        break;
      case ChallengeStatus.success:
        writer.writeByte(1);
        break;
      case ChallengeStatus.fail:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChallengeStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
