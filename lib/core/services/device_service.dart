import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:botanicare/constants.dart';

import '../../data/local/models/device_info.dart';

class DeviceService {
  static late Box<DeviceInfo> _box;

  /// Called once at app start
  static void setBox(Box<DeviceInfo> box) {
    _box = box;
  }

  static Future<void> registerOrRefreshToken() async {
    final saved = _box.isNotEmpty ? _box.getAt(0)! : DeviceInfo();

    await FirebaseMessaging.instance.requestPermission();
    final token = await FirebaseMessaging.instance.getToken();
    if (token == null) throw Exception('Cannot get Firebase device token');

    if (saved.id == null) {
      final headers = {'content-type': 'application/json'};
      final body = jsonEncode({'deviceMessagingToken': token});

      final response = await http.post(
        Uri.parse('${Constants.baseURL}/devices'),
        headers: headers,
        body: body,
      );

      if (response.statusCode != 200 || response.body.isEmpty)
        throw Exception('Device registration failed: ${response.statusCode}');

      final data = jsonDecode(response.body);
      saved.id = data['id'] as int?;
      saved.fcmToken = token;
    }

    if (_box.isEmpty) {
      await _box.add(saved);
    } else {
      await _box.putAt(0, saved);
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      _updateToken(newToken);
    });
  }

  static Future<void> _updateToken(String newToken) async {
    final saved = _box.getAt(0)!;
    if (saved.id == null) {
      return registerOrRefreshToken();
    }
    final uri = Uri.parse('${Constants.baseURL}/devices/${saved.id}');
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'deviceMessagingToken': newToken}),
    );
    if (response.statusCode == 200) {
      saved.fcmToken = newToken;
      await _box.putAt(0, saved);
    }
  }

  static Future<void> updateSettings(Map<String, dynamic> settings) async {
    final saved = _box.getAt(0);
    if (saved == null || saved.id == null) return;
    final uri = Uri.parse('${Constants.baseURL}/devices/${saved.id}');
    await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'settings': settings}),
    );
  }

  static Future<void> sendTestMessage() async {
    final saved = _box.getAt(0);
    if (saved == null || saved.id == null) return;
    final response = await http.get(
      Uri.parse('${Constants.baseURL}/devices/${saved.id}/message'),
    );
    if (response.statusCode != 200) {
      throw Exception(
        '(Device ${saved.id}): Test message failed: ${response.statusCode} ${response.body}',
      );
    }
  }
}
