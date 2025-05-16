import 'dart:convert';
import 'package:botanicare/constants.dart';
import 'package:http/http.dart' as http;
import '../models/plant.dart';
import '../models/room.dart';

class RoomService {
  Future<List<Room>> getAllRooms() async {
    final response = await http.get(Uri.parse("${Constants.baseURL}/rooms"));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Room.fromJson(data)).toList();
    } else {
      throw Exception("Räume konnten nicht geladen werden.");
    }
  }

  Future<List<Plant>> getAllPlantsFromRoom(String roomName) async {
    final response = await http.get(
      Uri.parse("${Constants.baseURL}/rooms/$roomName/plants"),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      //TODO: fromJson in Plant
      return jsonResponse.map((data) => Plant.fromJson(data)).toList();
    }
    throw Exception("Pflanzen konnten nicht geladen werden.");
  }

  Future<void> addRoom(String roomName) async {
    //check if roomName is Empty
    if (roomName.trim().isEmpty) {
      throw Exception("Ein Raum muss einen Namen haben.");
    }

    final response = await http.post(
      Uri.parse("${Constants.baseURL}/rooms"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'roomName': roomName}),
    );

    if (response.statusCode != 201) {
      throw Exception("Raum konnte nicht erstellt werden.");
    }
  }

  Future<void> deleteRoom(String roomName) async {
    final response = await http.delete(
      Uri.parse("${Constants.baseURL}/rooms/$roomName"),
    );
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Raum konnte nicht gelöscht werden.");
    }
  }
}
