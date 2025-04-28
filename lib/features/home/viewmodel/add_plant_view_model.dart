import 'dart:io';

import 'package:flutter/material.dart';

class PlantDefaults {
  final String type;
  final String waterNeed;
  final String sunlight;

  PlantDefaults({
    required this.type,
    required this.waterNeed,
    required this.sunlight,
  });
}

class AddPlantViewModel extends ChangeNotifier {
  String? name;
  String? type;
  String? waterNeed = 'normal';
  String? sunlight = 'sonnig';
  String? room;
  File? plantImage;

  final List<String> rooms = ['Wohnzimmer', 'Küche', 'Balkon'];

  // Neue Liste von Pflanzen mit Defaults
  final List<PlantDefaults> plantDefaults = [
    PlantDefaults(type: 'Ficus', waterNeed: 'normal', sunlight: 'teilweise sonnig'),
    PlantDefaults(type: 'Monstera', waterNeed: 'hoch', sunlight: 'nicht sonnig'),
    PlantDefaults(type: 'Aloe Vera', waterNeed: 'gering', sunlight: 'sonnig'),
  ];

  List<String> get plantTypesFromDb => plantDefaults.map((p) => p.type).toList();

  void setType(String? newType) {
    type = newType;

    final selectedPlant = plantDefaults.firstWhere(
          (plant) => plant.type == newType,
      orElse: () => PlantDefaults(type: '', waterNeed: 'normal', sunlight: 'sonnig'),
    );

    waterNeed = selectedPlant.waterNeed;
    sunlight = selectedPlant.sunlight;
    notifyListeners();
  }

  void addRoom(String newRoom) {
    if (!rooms.contains(newRoom)) {
      rooms.add(newRoom);
      room = newRoom;
      notifyListeners();
    }
  }

  void setImage(File image) {
    plantImage = image;
    notifyListeners();
  }

  void clearImage() {
    plantImage = null;
    notifyListeners();
  }

  void savePlant() {
    debugPrint('🌱 Neue Pflanze gespeichert:');
    debugPrint('Name: $name');
    debugPrint('Art: $type');
    debugPrint('Wasser: $waterNeed');
    debugPrint('Sonne: $sunlight');
    debugPrint('Raum: $room');
  }
}

