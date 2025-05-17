// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationSettingsAdapter extends TypeAdapter<NotificationSettings> {
  @override
  final int typeId = 3;

  @override
  NotificationSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationSettings(
      allowAll: fields[0] as bool,
      push: fields[1] as bool,
      sms: fields[2] as bool,
      email: fields[3] as bool,
      dailyTasks: fields[4] as bool,
      criticalCondition: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationSettings obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.allowAll)
      ..writeByte(1)
      ..write(obj.push)
      ..writeByte(2)
      ..write(obj.sms)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.dailyTasks)
      ..writeByte(5)
      ..write(obj.criticalCondition);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
