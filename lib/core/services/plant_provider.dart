import 'dart:io';
import 'package:flutter/material.dart';
import '../models/plant.dart';

class PlantProvider extends ChangeNotifier {
  final List<Plant> _plants = [
    Plant(
      id: 0,
      name: "Pflanzi",
      type: "Monstera",
      waterNeed: "hoch",
      sunlight: "sonnig",
      roomId: 0,
      isWatered: false,
      image: File(''), // Placeholder
    ),
    Plant(
      id: 1,
      name: "Pflanzinchen",
      type: "Monstera",
      waterNeed: "hoch",
      sunlight: "sonnig",
      roomId: 1,
      isWatered: false,
      image: File(''), // Placeholder
    ),
    Plant(
      id: 2,
      name: "Franz die Pflanze",
      type: "Monstera",
      waterNeed: "hoch",
      sunlight: "sonnig",
      roomId: 0,
      isWatered: false,
      image: File(''), // Placeholder
    ),
    Plant(
      id: 3,
      name: "Maple",
      type: "Monstera",
      waterNeed: "hoch",
      sunlight: "sonnig",
      roomId: 2,
      isWatered: false,
      image: File(''), // Placeholder
    ),
    Plant(
      id: 4,
      name: "Raumlose Pflanze",
      type: "Monstera",
      waterNeed: "hoch",
      sunlight: "sonnig",
      roomId: null,
      isWatered: false,
      image: File(''), // Placeholder
    ),
    Plant(
      id: 5,
      name: "raumlose Pflanze 1",
      type: "Monstera",
      waterNeed: "hoch",
      sunlight: "sonnig",
      roomId: null,
      isWatered: false,
      image: File(''), // Placeholder
    ),
  ];

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

  void removeRoomFromPlants(int roomId) {
    for (var plant in _plants) {
      if (plant.roomId == roomId) {
        plant.roomId = null;
      }
    }
    notifyListeners();
  }
}
