import 'package:botanicare/features/home/models/room.dart';
import 'package:flutter/cupertino.dart';

import '../models/plant.dart';

class RoomProvider extends ChangeNotifier {
  final List<Room> _rooms = [
    Room(id: 0, roomName: "Wohnzimmer"),

    Room(id: 1, roomName: "Schlafzimmer"),

    Room(id: 2, roomName: "Küche"),

    Room(id: 3, roomName: "Büro"),

    Room(id: 4, roomName: "Gästezimmer"),
  ];

  List<Room> get rooms => _rooms;

  List<Plant> getPlantsByRoom(List<Plant> plants, int roomId) {
    return plants.where((plant) => plant.roomId == roomId).toList();
  }

  List<Plant> getPlantsWithNoRoom(List<Plant> plants) {
    return plants.where((plant) => plant.roomId == null).toList();
  }

  deleteRoom(int id) {
    _rooms.removeWhere((room) => room.id == id);
    notifyListeners();
  }
}
