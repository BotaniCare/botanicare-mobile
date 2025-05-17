import 'package:botanicare/core/services/device_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:botanicare/data/local/models/notifications.dart';

extension NotificationSettingsJson on NotificationSettings {
  Map<String, dynamic> toJson() => {
    'allowAll': allowAll,
    'push': push,
    'sms': sms,
    'email': email,
    'dailyTasks': dailyTasks,
    'criticalCondition': criticalCondition,
  };
}

class NotificationNotifier with ChangeNotifier {
  final Box<NotificationSettings> _box;
  NotificationSettings _settings;

  NotificationNotifier._(this._box, this._settings);

  /// Factory to open the box and load (or create) settings
  static Future<NotificationNotifier> create() async {
    final box = await Hive.openBox<NotificationSettings>('notifications');
    NotificationSettings settings;
    if (box.isNotEmpty) {
      settings = box.getAt(0)!;
    } else {
      settings = NotificationSettings.initial();
      await box.add(settings);
    }
    return NotificationNotifier._(box, settings);
  }

  // Expose each flag
  bool get allowAll           => _settings.allowAll;
  bool get push               => _settings.push;
  bool get sms                => _settings.sms;
  bool get email              => _settings.email;
  bool get dailyTasks         => _settings.dailyTasks;
  bool get criticalCondition  => _settings.criticalCondition;

  // Generic updater to save & notify
  void _update(void Function(NotificationSettings) mutate) {
    mutate(_settings);
    _box.putAt(0, _settings);
    notifyListeners();
    DeviceService.updateSettings(_settings.toJson());
  }

  // Public API for toggles:
  void setAllowAll(bool v)           => _update((s) => s.allowAll = v);
  void setPush(bool v)               => _update((s) => s.push = v);
  void setSms(bool v)                => _update((s) => s.sms = v);
  void setEmail(bool v)              => _update((s) => s.email = v);
  void setDailyTasks(bool v)         => _update((s) => s.dailyTasks = v);
  void setCriticalCondition(bool v)  => _update((s) => s.criticalCondition = v);
}
