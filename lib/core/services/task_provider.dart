import 'package:botanicare/core/services/task_service.dart';
import 'package:flutter/material.dart';
class TaskProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();

  //TODO: call this after creating a plant
  Future<void> createPlantTasks() async {
    await _taskService.createPlantTask();
    notifyListeners();
  }
}
