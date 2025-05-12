import 'package:botanicare/features/home/models/room.dart';
import 'package:botanicare/features/home/viewmodel/plant_provider.dart';
import 'package:flutter/cupertino.dart';

import '../models/plant.dart';

class RoomProvider extends ChangeNotifier {
  // dynamic list, which has to be saved in the database
  final List<Room> _rooms = [
    Room(
      id: 0,
      roomName: "Wohnzimmer",
    ),

    Room(
      id: 1,
      roomName: "Schlafzimmer",
    ),
  ];

  List<Room> get rooms => _rooms;

  List<Plant> getPlantsByRoom(List<Plant> plants, int roomId) {
    return plants.where((plant) => plant.roomId == roomId).toList();
  }

  List<Plant> getPlantsWithNoRoom(List<Plant> plants) {
    return plants.where((plant) => plant.roomId == null).toList();
  }

  addRoom(Room room){
      _rooms.add(Room(id: _rooms.length, roomName: room.roomName));
      notifyListeners();
  }

  deleteRoom(int id, PlantProvider plantProvider) {
    _rooms.removeWhere((room) => room.id == id);
    notifyListeners();

    plantProvider.removeRoomFromPlants(id);
  }

  bool roomExists(String roomName) {
    for(final room in rooms) {
      if(room.roomName == roomName) {
        return true;
      }
    }
    return false;
  }
}