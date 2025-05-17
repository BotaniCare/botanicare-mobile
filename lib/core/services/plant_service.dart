import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants.dart';
import '../models/plant.dart';

class PlantService {

  static Future<List<Plant>> getAllPlants() async {
    final response = await http.get(Uri.parse(Constants.apiUrlPlants));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => Plant.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load plants');
    }
  }

  static Future<Plant> getPlantById(int id) async {
    final response = await http.get(Uri.parse('${Constants.apiUrlPlants}/$id'));

    if (response.statusCode == 200) {
      return Plant.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load plant with ID $id');
    }
  }

  static Future<void> updatePlant(Plant plant) async {
    final response = await http.put(
      Uri.parse('${Constants.apiUrlPlants}/${plant.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(plant.toJsonEditing()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update plant with ID ${plant.id}');
    }
  }

  static Future<void> deletePlant(int id) async {
    final response = await http.delete(
        Uri.parse('${Constants.apiUrlPlants}/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete plant with ID $id');
    }
  }

}


