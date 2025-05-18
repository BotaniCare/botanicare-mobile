// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ThemeAdapter extends TypeAdapter<Theme> {
  @override
  final int typeId = 2;

  @override
  Theme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Theme(
      themeMode: fields[0] as ThemeModeSetting,
      contrastLevel: fields[1] as ContrastLevel,
    );
  }

  @override
  void write(BinaryWriter writer, Theme obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.themeMode)
      ..writeByte(1)
      ..write(obj.contrastLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThemeModeSettingAdapter extends TypeAdapter<ThemeModeSetting> {
  @override
  final int typeId = 0;

  @override
  ThemeModeSetting read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ThemeModeSetting.light;
      case 1:
        return ThemeModeSetting.dark;
      case 2:
        return ThemeModeSetting.system;
      default:
        return ThemeModeSetting.light;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeModeSetting obj) {
    switch (obj) {
      case ThemeModeSetting.light:
        writer.writeByte(0);
        break;
      case ThemeModeSetting.dark:
        writer.writeByte(1);
        break;
      case ThemeModeSetting.system:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeModeSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ContrastLevelAdapter extends TypeAdapter<ContrastLevel> {
  @override
  final int typeId = 1;

  @override
  ContrastLevel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ContrastLevel.low;
      case 1:
        return ContrastLevel.medium;
      case 2:
        return ContrastLevel.high;
      default:
        return ContrastLevel.low;
    }
  }

  @override
  void write(BinaryWriter writer, ContrastLevel obj) {
    switch (obj) {
      case ContrastLevel.low:
        writer.writeByte(0);
        break;
      case ContrastLevel.medium:
        writer.writeByte(1);
        break;
      case ContrastLevel.high:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContrastLevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
