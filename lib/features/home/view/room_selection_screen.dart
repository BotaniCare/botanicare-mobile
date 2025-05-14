import 'package:botanicare/features/home/viewmodel/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../assets/constants.dart';
import '../widgets/room_card.dart';

class RoomSelectionScreen extends StatelessWidget {
  const RoomSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: true);
    final roomList = roomProvider.rooms;

    return Scaffold(
      appBar: AppBar(title: Text(Constants.roomScreenTitle)),
      body: ListView(
        children: [
          ...roomList.map(
            (room) => RoomCard(
              room: room,
              imagePath:
                  room.roomName.toLowerCase() ==
                          Constants.livingroom.toLowerCase()
                      ? Constants.livingroomImage
                      : room.roomName.toLowerCase() ==
                          Constants.bedroom.toLowerCase()
                      ? Constants.bedroomImage
                      : room.roomName.toLowerCase() ==
                          Constants.kitchen.toLowerCase()
                      ? Constants.kitchenImage
                      : room.roomName.toLowerCase() ==
                          Constants.office.toLowerCase()
                      ? Constants.officeImage
                      : room.roomName.toLowerCase() ==
                          Constants.bathroom.toLowerCase()
                      ? Constants.bathroomImage
                      : room.roomName.toLowerCase() ==
                          Constants.balcony.toLowerCase()
                      ? Constants.balconyImage
                      : Constants.defaultImage,
            ),
          ),
          //bottom margin to prevent actionButton overlap
          SizedBox(height: 73),
        ],
      ),
    );
  }
}
