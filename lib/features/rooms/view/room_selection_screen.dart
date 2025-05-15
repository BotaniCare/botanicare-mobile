import 'package:botanicare/core/services/room_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../assets/constants.dart';
import '../../../core/services/plant_provider.dart';
import '../../../shared/ui/add_button.dart';
import '../../home/view/add_room_form.dart';
import '../../home/viewmodel/add_room_view_model.dart';
import 'room_card.dart';

class RoomSelectionScreen extends StatefulWidget {
  const RoomSelectionScreen({super.key});

  @override
  State<RoomSelectionScreen> createState() => _RoomSelectionScreenState();
}

class _RoomSelectionScreenState extends State<RoomSelectionScreen> {

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context, listen: true);
    final plantProvider = Provider.of<PlantProvider>(context, listen: true);
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
      floatingActionButton: AddButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
              return ChangeNotifierProvider(
                create: (_) => AddRoomViewModel(roomProvider: roomProvider, plantProvider: plantProvider),
                child: const AddRoomForm(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
