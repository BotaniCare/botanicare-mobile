import 'package:botanicare/features/home/models/room_form.dart';
import 'package:botanicare/features/home/viewmodel/room_provider.dart';
import 'package:flutter/material.dart';

import '../models/room_display.dart';

class AddRoomViewModel extends ChangeNotifier {
  final RoomProvider roomProvider;
  late List<RoomDisplay> rooms;
  List<RoomDefault> defaultRooms = [
    RoomDefault(id: 0, imageUrl: "https://cdn.pixabay.com/photo/2016/09/19/17/20/home-1680800_1280.jpg", roomName: "Wohnzimmer", checked: false),
    RoomDefault(id: 1, imageUrl: "https://cdn.pixabay.com/photo/2021/12/22/16/57/room-6887944_1280.jpg", roomName: "Schlafzimmer", checked: false),
    RoomDefault(id: 2, imageUrl: "https://cdn.pixabay.com/photo/2017/03/22/17/39/kitchen-2165756_1280.jpg", roomName: "Küche", checked: false)
  ];
  String otherRoomUrl = "https://cdn.pixabay.com/photo/2017/08/06/22/20/interior-2596976_1280.jpg";

  AddRoomViewModel({required this.roomProvider}) {
    rooms = this.roomProvider.roomsDisplay;
    for(final room in rooms) {
      for(var i=0; i< defaultRooms.length; i++) {
        if(room.roomName == defaultRooms[i].roomName) {
          defaultRooms[i].checked = true;
        }
      }
    }
  }

  void saveForm(){
      for(var x=0; x < defaultRooms.length; x++){
        if(defaultRooms[x].checked) {
            roomProvider.addDefaultRoomIfNotExists(defaultRooms[x]);
        } else {
            roomProvider.removeDefaultRoomIfExists(defaultRooms[x]);
            // ToDo: Add Snackbar to confirm, that the room should be deleted
        }
      }
  }

  bool validateForm() {
    return true;
  }
}