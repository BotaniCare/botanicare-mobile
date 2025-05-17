import 'package:botanicare/core/services/task_service.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {

  //TODO: call this after creating a plant
  Future<void> createPlantTasks() async {
    await TaskService.createPlantTask();
    notifyListeners();
  }
}
