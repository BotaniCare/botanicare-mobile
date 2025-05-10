import 'dart:io';
import 'package:flutter/material.dart';
import '../models/plant.dart';

class PlantProvider extends ChangeNotifier {
  final List<Plant> _plants = List.generate(
    7,
        (index) => Plant(
      id: index,
      name: "Pflanzi",
      type: "Monstera",
      waterNeed: "hoch",
      sunlight: "sonnig",
      room: 'Balkon',
      image: File(''), // Placeholder
    ),
  );

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

  int getNumberOfPlants() {
    return _plants.length;
  }
}
