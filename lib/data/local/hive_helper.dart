import 'package:botanicare/data/local/models/device_info.dart';
import 'package:botanicare/data/local/models/notifications.dart';
import 'package:botanicare/data/local/models/theme.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register ALL enum and model adapters
    Hive.registerAdapter(ThemeModeSettingAdapter());
    Hive.registerAdapter(ContrastLevelAdapter());
    Hive.registerAdapter(ThemeAdapter());
    Hive.registerAdapter(NotificationSettingsAdapter());
    Hive.registerAdapter(DeviceInfoAdapter());
  }

  static Future<Box<Theme>> openThemeBox() async {
    return await Hive.openBox<Theme>('theme');
  }

  static Future<Box<DeviceInfo>> openDeviceInfo() async {
    return await Hive.openBox<DeviceInfo>('deviceInfo');
  }
}