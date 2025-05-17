import 'package:botanicare/core/services/task_service.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {

  Future<void> createPlantTasks() async {
    await TaskService.createPlantTask();
    notifyListeners();
  }
}
