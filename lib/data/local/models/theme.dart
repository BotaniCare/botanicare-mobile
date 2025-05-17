import 'package:hive/hive.dart';

part 'theme.g.dart';

@HiveType(typeId: 0)
enum ThemeModeSetting {
  @HiveField(0)
  light,

  @HiveField(1)
  dark,

  @HiveField(2)
  system,
}

@HiveType(typeId: 1)
enum ContrastLevel {
  @HiveField(0)
  low,

  @HiveField(1)
  medium,

  @HiveField(2)
  high,
}

@HiveType(typeId: 2)
class Theme {
  @HiveField(0)
  ThemeModeSetting themeMode;

  @HiveField(1)
  ContrastLevel contrastLevel;

  Theme({required this.themeMode, required this.contrastLevel});

  factory Theme.initial() {
    return Theme(
      themeMode: ThemeModeSetting.system,
      contrastLevel: ContrastLevel.low,
    );
  }
}