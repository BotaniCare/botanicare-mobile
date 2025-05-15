import 'dart:io';
import 'package:flutter/material.dart';

import '../../../core/models/plant.dart';
import '../../../core/services/plant_provider.dart';
import '../../../core/models/room.dart';
import '../../../core/services/room_provider.dart';

class AddPlantViewModel extends ChangeNotifier {
  final PlantProvider plantProvider;
  final bool isEditing;
  final RoomProvider roomProvider;

  // Internal state
  late Plant _plant;
  late String isWatered;

  AddPlantViewModel({
    required this.isEditing,
    required this.plantProvider,
    required this.roomProvider,
    required Plant initialPlant,
  }) {
    _plant = initialPlant;
    if (_plant.isWatered) {
      isWatered = "Ja";
    }
    isWatered = "Nein";
  }

  Plant get plant => _plant;
  List<Room> get rooms => roomProvider.rooms;

  void updateIsWatered(String watered) {
    isWatered = watered;
    if (isWatered == "Ja") {
      plant.isWatered = true;
    }
    plant.isWatered = false;
  }

  void setType(String newType) {
    _plant.type = newType;
    notifyListeners();
  }

  void setRoom(int roomId) {
    _plant.roomId = roomId;
    notifyListeners();
  }

  int addRoomIfNew(String room) {
    return roomProvider.addRoomReturnId(room);
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

  void updateType(String type) {
    _plant.type = type;
    notifyListeners();
  }

  String? validateForm() {
    if (_plant.name.isEmpty) return 'Bitte füge einen Namen hinzu';
    if (_plant.image == null) return 'Bitte füge ein Bild hinzu.';
    if (_plant.type.trim().isEmpty) return 'Bitte gib eine Pflanzenart ein';
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
