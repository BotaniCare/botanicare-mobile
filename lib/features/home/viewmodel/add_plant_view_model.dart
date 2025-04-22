import 'package:flutter/material.dart';

class AddPlantViewModel extends ChangeNotifier {
  String? name;
  String? type;
  String? waterNeed = 'normal';
  String? sunlight = 'sonnig';
  String? room;

  final List<String> plantTypesFromDb = ['Ficus', 'Monstera', 'Aloe Vera'];
  final Map<String, String> waterNeedDefaults = {
    'Ficus': 'normal',
    'Monstera': 'hoch',
    'Aloe Vera': 'gering',
  };

  final List<String> rooms = ['Wohnzimmer', 'Küche', 'Balkon'];

  void setType(String? newType) {
    type = newType;
    waterNeed = waterNeedDefaults[newType] ?? 'normal';
    notifyListeners();
  }

  void addRoom(String newRoom) {
    if (!rooms.contains(newRoom)) {
      rooms.add(newRoom);
      room = newRoom;
      notifyListeners();
    }
  }

  void savePlant() {
    // Hier kannst du z. B. die Daten speichern oder an DB weitergeben
    debugPrint('🌱 Neue Pflanze gespeichert:');
    debugPrint('Name: $name');
    debugPrint('Art: $type');
    debugPrint('Wasser: $waterNeed');
    debugPrint('Sonne: $sunlight');
    debugPrint('Raum: $room');
  }
}
