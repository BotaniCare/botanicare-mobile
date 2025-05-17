import 'package:hive/hive.dart';

part 'notifications.g.dart';

@HiveType(typeId: 3)
class NotificationSettings {
  @HiveField(0)
  bool allowAll;

  @HiveField(1)
  bool push;

  @HiveField(2)
  bool sms;

  @HiveField(3)
  bool email;

  @HiveField(4)
  bool dailyTasks;

  @HiveField(5)
  bool criticalCondition;

  NotificationSettings({
    required this.allowAll,
    required this.push,
    required this.sms,
    required this.email,
    required this.dailyTasks,
    required this.criticalCondition,
  });

  factory NotificationSettings.initial() => NotificationSettings(
    allowAll: false,
    push: false,
    sms: false,
    email: false,
    dailyTasks: true,
    criticalCondition: true,
  );
}
