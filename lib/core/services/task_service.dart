import 'dart:convert';
import 'package:botanicare/constants.dart';
import 'package:botanicare/core/services/room_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/plant.dart';
import '../models/room.dart';
import '../models/task.dart';

class TaskService {
  static Future<List<Task>> getTaskFromPlant(int plantId) async {
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

  static Future<List<Map<String, dynamic>>> getAllTasks() async {
    List<Map<String, dynamic>> roomWithTasks = [];
    List<Room> roomList = await RoomService.getAllRooms();

    //loop through each room to get their name
    for (Room room in roomList) {
      //get all Plants of the room
      List<Plant> plantList = await RoomService.getAllPlantsFromRoom(
        room.roomName,
      );
      List<Task> tasksOfRoom = [];

      //get the task of the each plant inside the room
      for (Plant plant in plantList) {
        List<Task> taskOfPlant = await TaskService.getTaskFromPlant(plant.id);
        tasksOfRoom.addAll(taskOfPlant);
      }

      //link room to tasks
      roomWithTasks.add({'room': room, 'tasks': tasksOfRoom});
    }

    return roomWithTasks;
  }

  static Future<void> createTask(int plantId, Task task) async {
    final response = await http.post(
      Uri.parse("${Constants.baseURL}/plants/$plantId/tasks"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Task konnte nicht erstellt werden.");
    }
  }

  static Future<void> createPlantTask() async {
    try {
      List<Room> roomList = await RoomService.getAllRooms();

      //loop through all the rooms to get each room name
      for (Room room in roomList) {
        //pass room name to getAllPlantsFromRoom
        List<Plant> plantList = await RoomService.getAllPlantsFromRoom(
          room.roomName,
        );

        //loop through all plants in room to get plant id and to check isWatered
        for (Plant plant in plantList) {
          //check isWatered is false
          if (!plant.isWatered) {
            //pass plant id to getTaskFromPlant
            List<Task> taskList = await getTaskFromPlant(plant.id);
            //check for any task with condition: plant id of task is the same as plant id
            bool isTaskAlreadyCreated = taskList.any(
              (task) => task.plant.id == plant.id,
            );
            //create task with the plant id only if not created yet
            if (!isTaskAlreadyCreated) {
              Task task = Task(description: "Gieß mich!", plant: plant);
              await createTask(plant.id, task);
            }
          }
        }
      }
    } catch (e) {
      debugPrint("----- Check this exception $e");
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static Future<void> deleteTask(int plantId, int taskId) async {
    final response = await http.delete(
      Uri.parse("${Constants.baseURL}/plants/$plantId/tasks/$taskId"),
    );
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Aufgabe könnte nicht gelöscht werden.");
    }
  }
}
