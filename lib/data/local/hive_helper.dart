import 'package:botanicare/data/local/models/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ThemeAdapter());
  }

  static Future<Box<Theme>> openThemeBox() async {
    return await Hive.openBox<Theme>('theme');
  }
}