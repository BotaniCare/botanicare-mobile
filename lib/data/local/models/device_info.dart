import 'package:hive/hive.dart';

part 'device_info.g.dart';

@HiveType(typeId: 4)
class DeviceInfo {
  @HiveField(0)
  int? id;                // the backend deviceId

  @HiveField(1)
  String? fcmToken;       // the last known token

  DeviceInfo({this.id, this.fcmToken});
}
