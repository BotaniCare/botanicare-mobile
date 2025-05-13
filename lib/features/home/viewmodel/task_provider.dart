import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  List<Plant> getUnwateredPlants(List<Plant> plantList) {
    return plantList.where((plant) => plant.isWatered == false).toList();
  }

  List<Task> addTask(List<Plant> plantList) {
    final unwateredPlantsList = getUnwateredPlants(plantList);
    for (int i = 0; i < unwateredPlantsList.length; i++) {
      final taskAlreadyCreatedCondition = _tasks.any(
        (task) => task.plant.id == unwateredPlantsList[i].id,
      );
      if (!taskAlreadyCreatedCondition) {
        _tasks.add(Task(id: _tasks.length, plant: unwateredPlantsList[i]));
      }
    }
    notifyListeners();
    return _tasks;
  }

  deleteTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}
