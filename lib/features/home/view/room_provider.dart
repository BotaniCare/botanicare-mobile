import 'dart:io';

import 'package:botanicare/features/home/models/room.dart';
import 'package:flutter/cupertino.dart';

import '../models/plant.dart';

class RoomProvider extends ChangeNotifier {
  final List<Room> _rooms = [
    Room(
      id: 0,
      roomName: "Wohnzimmer",
      roomPlants: [],
    ),

    Room(
      id: 1,
      roomName: "Küche",
      roomPlants: [],
    ),
  ];

  List<Room> get rooms => _rooms;

  void sortPlantsByRoom(List<Plant> plants) {
    for (var room in _rooms) {
      room.roomPlants.clear();
      room.roomPlants.addAll(plants.where((plant) => plant.roomId == room.id));
    }
    notifyListeners();
  }

  deleteRoom(int id) {
    _rooms.removeWhere((room) => room.id == id);
    notifyListeners();
  }
}