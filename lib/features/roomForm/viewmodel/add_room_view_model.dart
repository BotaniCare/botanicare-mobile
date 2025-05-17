import 'package:flutter/material.dart';
import '../../../core/exceptions/server_exception.dart';
import '../../../core/models/room.dart';
import '../../../core/services/room_service.dart';

class AddRoomViewModel extends ChangeNotifier {
  final Room? initialRoom;
  final bool isEditing;
  final RoomService roomService;
  String? newRoomName;

  AddRoomViewModel({
    this.initialRoom,
    required this.isEditing,
    required this.roomService
  });

  /*bool roomNameExists(String roomName) {
    return roomProvider.roomExists(roomName);
  }*/

  void saveForm(){
    if(isEditing){
      // ToDo is Editing
    } else {
      roomService.addRoom(newRoomName!);
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

  Future<String?> validateForm(String? newRoomName) async {
    print("Validating: $newRoomName");

    if (!newRoomIsValid(newRoomName)) {
      print("Bitte gib einen Raumnamen ein");
      return "Bitte gib einen Raumnamen ein";
    }

    try {
      final rooms = await RoomService.getAllRooms();
      final exists = rooms.any((room) => room.roomName.toLowerCase() == newRoomName!.trim().toLowerCase());
      print("Testet ob es exisitet");
      if (exists) {
        return "Ein Raum mit diesem Namen existiert bereits.";
      }
    } on ServerException catch (e) {
      return "Fehler beim Überprüfen des Raumnamens: ${e.message}";
    } catch (e) {
      debugPrint(e.toString());
      return "Unbekannter Fehler bei der Validierung.";
    }

    return null;
  }


}