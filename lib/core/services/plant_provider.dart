import 'package:flutter/material.dart';
import '../models/plant.dart';

class PlantProvider extends ChangeNotifier {
  final List<Plant> _plants = [];

  List<Plant> get plants => _plants;

  void addPlant(Plant plant) {
    plant.id = getNumberOfPlants() - 1;
    _plants.add(plant);
    notifyListeners();
  }

  void updatePlant(Plant plant) {
    _plants[_plants.indexWhere((element) => element.id == plant.id)] = plant;
    notifyListeners();
  }

  void deletePlant(int id) {
    _plants.removeWhere((deletedPlant) => deletedPlant.id == id);
    notifyListeners();
  }

  int getNumberOfPlants() {
    return _plants.length;
  }
}
