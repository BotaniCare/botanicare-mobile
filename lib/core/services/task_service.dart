import 'dart:convert';
import 'package:botanicare/constants.dart';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class TaskService {
  Future<List<Task>> getTaskFromPlant(int plantId) async {
    final response = await http.get(
      Uri.parse("${Constants.baseURL}/plants/$plantId/tasks"),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception("Tasks konnten nicht geladen werden.");
    }
  }

  Future<void> createTask(int plantId, Task task) async {
    final response = await http.post(
      Uri.parse("${Constants.baseURL}/plants/$plantId/tasks"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Task konnte nicht erstellt werden.");
    }
  }

  Future<void> deleteTask(int plantId, int taskId) async {
    final response = await http.delete(Uri.parse("${Constants.baseURL}/plants/$plantId/tasks/$taskId"));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Aufgabe könnte nicht gelöscht werden.");
    }
  }
}
