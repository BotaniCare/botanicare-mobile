import 'dart:io';
import 'package:botanicare/core/models/image.dart';
import 'package:botanicare/core/services/room_service.dart';
import 'package:flutter/material.dart';

import '../../../core/models/plant.dart';
import '../../../core/services/plant_provider.dart';
import '../../../core/models/room.dart';
import '../../../core/services/room_provider.dart';

class AddPlantViewModel extends ChangeNotifier {
  final bool isEditing;
  final RoomService roomService;

  // Internal state
  late Plant _plant;
  late String isWatered;
  List<Room> rooms = [];
  late String roomName = "";

  AddPlantViewModel({
    required this.isEditing,
    required Plant initialPlant,
    required this.roomService,
  }) {
    _plant = initialPlant;
    if (_plant.isWatered) {
      isWatered = "Ja";
    }
    isWatered = "Nein";
  }

  Plant get plant => _plant;

  Future<void> loadRooms() async {
    rooms = await RoomService.getAllRooms();
    roomName = rooms.first.roomName;
    notifyListeners();
  }

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

  void setImage(String image) {
    _plant.image = PlantImage(id: 0, bytes: image);
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
    _plant.sunLight = sunlight;
    notifyListeners();
  }

  void updateType(String type) {
    _plant.type = type;
    notifyListeners();
  }

  void updateRoomName(String roomName){
    this.roomName = roomName;
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
      // TODO Api: update Plant
    } else {
      // TODO api add Plant
    }
    notifyListeners();
  }
}
