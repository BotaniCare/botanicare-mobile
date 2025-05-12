import 'package:botanicare/features/home/viewmodel/plant_provider.dart';
import 'package:botanicare/features/home/viewmodel/room_provider.dart';
import 'package:flutter/material.dart';

import '../models/room.dart';

class AddRoomViewModel extends ChangeNotifier {
  final RoomProvider roomProvider;
  final PlantProvider plantProvider;
  String? newRoom;

  AddRoomViewModel({required this.roomProvider, required this.plantProvider});

  bool roomNameExists(String roomName) {
    return roomProvider.roomExists(roomName);
  }

  void saveForm(){
      if(newRoomIsValid(newRoom)){
         if (!(roomNameExists(newRoom!))){
            roomProvider.addRoom(newRoom!);
         }
      }
  }

  bool newRoomIsValid(String? newRoom){
    if(newRoom == null){
      return false;
    } else if(newRoom.isEmpty){
      return false;
    } else {
      return true;
    }
  }

  String? validateForm() {
    if (newRoom != null) {
      if (roomNameExists(newRoom!)) {
        return "Der ausgewählte Raumname existiert bereits.";
      }
    }
    return null;
  }
}