import 'package:hive/hive.dart';

part 'theme.g.dart';

enum ThemeModeSetting {
  light,
  dark,
  system,
}

enum ContrastLevel {
  low,
  medium,
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
    return Theme(themeMode: ThemeModeSetting.system, contrastLevel: ContrastLevel.medium);
  }
}