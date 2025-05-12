import 'package:botanicare/features/home/models/room.dart';
import 'package:botanicare/features/home/models/room_form.dart';
import 'package:botanicare/features/home/viewmodel/plant_provider.dart';
import 'package:flutter/cupertino.dart';

import '../models/plant.dart';
import '../models/room_display.dart';

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

  // static list, which includes the defaults rooms
  final List<RoomDisplay> _roomsDisplay = [
    RoomDisplay(
      id: 0,
      roomName: "Wohnzimmer",
      imageUrl: 'https://cdn.pixabay.com/photo/2016/09/19/17/20/home-1680800_1280.jpg',
    ),

    RoomDisplay(
      id: 1,
      roomName: "Schlafzimmer",
      imageUrl: 'https://cdn.pixabay.com/photo/2021/12/22/16/57/room-6887944_1280.jpg',
    ),
  ];

  List<Room> get rooms => _rooms;

  List<Plant> getPlantsByRoom(List<Plant> plants, int roomId) {
    return plants.where((plant) => plant.roomId == roomId).toList();
  }

  List<Plant> getPlantsWithNoRoom(List<Plant> plants) {
    return plants.where((plant) => plant.roomId == null).toList();
  }

  List<RoomDisplay> get roomsDisplay => _roomsDisplay;

  addRoom(){

  }

  deleteRoom(int id, PlantProvider plantProvider) {
    _rooms.removeWhere((room) => room.id == id);
    _roomsDisplay.removeWhere((room) => room.id == id);
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

  void addDefaultRoomIfNotExists(RoomDefault defaultRoom) {
    if (!roomExists(defaultRoom.roomName)) {
      _rooms.add(Room(id: _rooms.length, roomName: defaultRoom.roomName));
      _roomsDisplay.add(RoomDisplay(id:_rooms.length, roomName: defaultRoom.roomName, imageUrl: defaultRoom.imageUrl));
    }
  }

  void removeDefaultRoomIfExists(RoomDefault defaultRoom, PlantProvider plantProvider) {
    for(final room in rooms) {
      if(room.roomName == defaultRoom.roomName) {
        deleteRoom(room.id, plantProvider);
      }
    }
  }
}