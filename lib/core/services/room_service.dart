import 'dart:convert';
import 'package:botanicare/constants.dart';
import 'package:botanicare/core/exceptions/server_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/plant.dart';
import '../models/room.dart';

class RoomService {
  static Future<List<Room>> getAllRooms() async {
    final response = await http.get(Uri.parse("${Constants.baseURL}/rooms"));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Room.fromJson(data)).toList();
    } else {
      throw ServerException("Interner Server Fehler", 500);
    }
  }

  Future<Room?> getRoomByName(String name) async {
    final response = await http.get(Uri.parse("${Constants.baseURL}/rooms/$name"));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return Room.fromJson(jsonResponse.first);
    }
    else if(response.statusCode == 505){
      throw ServerException("Interner Fehler", 500);
    }
    else {
      throw ServerException("Raum konnte nicht gefunden werden.", 400);
    }
  }

  static Future<List<Plant>> getAllPlantsFromRoom(String roomName) async {
    final response = await http.get(
      Uri.parse("${Constants.baseURL}/rooms/$roomName/plants"),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Plant.fromJson(data)).toList();
    }
    throw ServerException("Pflanzen konnten nicht geladen werden.", 500);
  }

  Future<void> addRoom(String roomName) async {
    final response = await http.post(Uri.parse(Constants.apiUrlRooms),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'roomName': roomName}),
    );

    if (response.statusCode != 201) {
      throw ServerException("Raum konnte nicht erstellt werden", 500);
    }
    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");

  }

  Future<void> deleteRoom(String roomName) async {
    final response = await http.delete(
      Uri.parse("${Constants.apiUrlRooms}/$roomName"),
    );
    if (response.statusCode == 400) {
      throw ServerException("Raum konnte gefunden werden", 404);
    } else if (response.statusCode == 500) {
      throw ServerException("Interner Server Fehler", 500);
    }
  }
}
