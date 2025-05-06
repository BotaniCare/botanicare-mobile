import 'dart:io';
import 'package:flutter/material.dart';

import '../models/plant_defaults.dart';
import '../../home/models/plant.dart';
import '../../home/viewmodel/plant_provider.dart';
import '../models/room.dart';
import '../view/room_provider.dart';

class AddPlantViewModel extends ChangeNotifier {
  final PlantProvider plantProvider;
  final bool isEditing;
  final RoomProvider roomProvider;

  // Internal state
  late Plant _plant;

  // Preset defaults
  final List<PlantDefaults> _plantDefaults = [
    PlantDefaults(type: 'Ficus', waterNeed: 'normal', sunlight: 'teilweise sonnig'),
    PlantDefaults(type: 'Monstera', waterNeed: 'hoch', sunlight: 'nicht sonnig'),
    PlantDefaults(type: 'Aloe Vera', waterNeed: 'gering', sunlight: 'sonnig'),
  ];

  AddPlantViewModel({
    required this.isEditing,
    required this.plantProvider,
    required this.roomProvider,
    required Plant initialPlant,
  }) {
    _plant = initialPlant;
  }

  Plant get plant => _plant;
  List<Room> get rooms => roomProvider.rooms;
  List<String> get plantTypesFromDb => _plantDefaults.map((p) => p.type).toList();

  void setType(String newType) {
    _plant.type = newType;

    final match = _plantDefaults.firstWhere(
          (e) => e.type == newType,
      orElse: () => PlantDefaults(type: '', waterNeed: 'normal', sunlight: 'sonnig'),
    );

    _plant.waterNeed = match.waterNeed;
    _plant.sunlight = match.sunlight;

    notifyListeners();
  }

  void setRoom(int roomId) {
    _plant.roomId = roomId;
    notifyListeners();
  }

  void addRoomIfNew(int roomId) {
    /*if (!_rooms.contains(room)) {
      _rooms.add(room);
      _plant.room = room;
      notifyListeners();
    }*/
    notifyListeners();
    //TODO: add Room through Room Provider
  }

  void removeRoom(int roomId) {
    if (_plant.roomId == roomId) {
      _plant.roomId = null;
      notifyListeners();
    }
  }

  void setImage(File image) {
    _plant.image = image;
    notifyListeners();
  }

  void clearImage() {
    _plant.image = null;
    notifyListeners();
  }

  void updateName(String name) {
    _plant.name = name;
    notifyListeners();
  }

  void updateWaterNeed(String need) {
    _plant.waterNeed = need;
    notifyListeners();
  }

  void updateSunlight(String sunlight) {
    _plant.sunlight = sunlight;
    notifyListeners();
  }

  void updateCustomType(String customType) {
    _plant.type = customType;
    notifyListeners();
  }

  String? validateForm() {
    if (_plant.name.isEmpty) return 'Bitte füge einen Namen hinzu';
    if (_plant.image == null) return 'Bitte füge ein Bild hinzu.';
    if (_plant.type.trim().isEmpty) return 'Bitte gib eine Pflanzenart ein oder wähle eine.';
    return null; // no error
  }

  void save() {
    if (isEditing) {
      plantProvider.updatePlant(_plant);
    } else {
      plantProvider.addPlant(_plant);
    }
    notifyListeners();
  }
}
