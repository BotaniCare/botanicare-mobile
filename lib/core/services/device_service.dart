import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:botanicare/constants.dart';

import '../../data/local/models/device_info.dart';

class DeviceService {
  static late Box<DeviceInfo> _box;

  /// Called once at app start
  static void setBox(Box<DeviceInfo> box) {
    _box = box;
  }

  static Future<void> registerOrRefreshToken() async {
    // 1) Load saved deviceInfo (if any)
    final saved = _box.isNotEmpty ? _box.getAt(0)! : DeviceInfo();

    // 2) Request permissions & get token
    await FirebaseMessaging.instance.requestPermission();
    final token = await FirebaseMessaging.instance.getToken();
    print(token);
    if (token == null) return;

    // 3) Decide POST vs PUT
    final uri = saved.id == null
        ? Uri.parse('${Constants.baseURL}/devices')
        : Uri.parse('${Constants.baseURL}/devices/${saved.id}');

    final body = jsonEncode({'deviceMessagingToken': token});
    final http.Response response;
    if (saved.id == null) {
      response = await http.post(uri, headers: {'content-type': 'application/json'}, body: body);
    } else {
      response = await http.put(uri, headers: {'content-type': 'application/json'}, body: body);
    }

    /*if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      saved.id = data['id'];
      saved.fcmToken = token;
      if (_box.isEmpty) {
        await _box.add(saved);
      } else {
        await _box.putAt(0, saved);
      }
    } else {
      throw Exception('Device registration failed: ${response.statusCode}');
    }*/
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.isNotEmpty) {
        // only decode if there’s something to parse
        final data = jsonDecode(response.body);
        saved.id = data['id'] as int?;
        saved.fcmToken = token;
      } else {
        // no body returned — assume the backend at least stored the token,
        // but we have no id to PUT later. You might skip saving id,
        // or trigger a GET /devices?token=<token> to retrieve it.
      }
      // now persist to Hive as before
      if (_box.isEmpty) {
        await _box.add(saved);
      } else {
        await _box.putAt(0, saved);
      }
    } else {
      throw Exception('Device registration failed: ${response.statusCode}');
    }

    // 4) Listen for token refresh
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
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'settings': settings}),
    );
    // handle errors if you like
  }
}

